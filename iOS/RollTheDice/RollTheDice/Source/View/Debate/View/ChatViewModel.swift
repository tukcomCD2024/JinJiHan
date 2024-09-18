//
//  ChatViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 9/19/24.
//

import Foundation
import OpenAI
import Combine
import Moya

@Observable
class ChatViewModel: ObservableObject {
    
    var newsId: Int?
    var chatList: DebateChat?
    var openAI: OpenAI?
    var sendContent: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<DebateService>(plugins: [MoyaLoggingPlugin()])
    var jsonDecoder = JSONDecoder()
    
    init(
        apiToken: String = "" //깃허브 보안 이슈로 계속 제거해야됨.
    ) {
        self.openAI = OpenAI(apiToken: apiToken)
    }
}

extension ChatViewModel {
    
    func sendInitialMessage(roomId: Int, content: String) {
        
        let messages = [Chat(role: .user, content: "너는 나와 \(content)에 관하여 토론하는 토론자 겸 사회자야. 네가 먼저 이 주제에 대해 토론을 시작하는 문장으로 토론을 시작해줘. 내 말에 대답하는 문구는 제외하렴. 토론 중에는 존댓말을 쓰도록하자.")]


        openAI!.chats(
            query: .init(
                model: .gpt3_5Turbo,
                messages: messages
            )
        ) { [weak self] result in
        

            switch result {
            case .success(let success):
                guard let choice = success.choices.first else {
                    return
                }
                let message = choice.message.content

                DispatchQueue.main.async {
                    self?.chatList?.data?.append(.init(message: message, senderType: .ai))
                }
                
                self?.saveDebateAI(roomId: roomId, message: message ?? "")
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func sendUserMessage(roomId: Int, content: String) {
        let humanMessage = Message(message: content, senderType: .human)
        
        self.chatList?.data?.append(humanMessage)
        
        self.saveDebateHuman(roomId: roomId, message: content)
        
        getBotReply(roomId: roomId)
    }
    
    func getBotReply(roomId: Int) {
            print("call getBotReply func")
    
            let messages = self.chatList?.data?.map {
                Chat(role: .user, content: $0.message)
            } ?? []
    
            openAI!.chats(
                query: .init(
                    model: .gpt3_5Turbo,
                    messages: messages
                )
            ) { [weak self] result in
            
    
                switch result {
                case .success(let success):
                    guard let choice = success.choices.first else {
                        return
                    }
                    let message = choice.message.content
    
                    DispatchQueue.main.async {
                        self?.chatList?.data?.append(.init(message: message, senderType: .ai))
                    }
                    
                    self?.saveDebateAI(roomId: roomId, message: message ?? "")
                    
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    

    // 토론방에 있는 모든 메시지 조회
    func getDebatesMsg(roomId: Int) {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        print("토론방 메시지 조회 요청 시작")
        provider.requestPublisher(.getDebatesMsg(roomId: roomId, accessToken: accessToken))
            .map(DebateChat.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("토론방 메시지 조회 실패 - 에러: \(error)")
                case .finished:
                    print("토론방 메시지 조회 완료")
                }
            }, receiveValue: { [weak self] chat in
                print(chat)
                self?.chatList = chat
                for item in chat.data ?? [] {
                    print("채팅 \(item)")
                }
            })
            .store(in: &cancellables)
    }
    
    func saveDebateHuman(roomId: Int, message: String) {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        print("Human 메시지 저장 시작")
        provider.requestPublisher(.saveDebatesHuman(roomId: roomId, message: message, accessToken: accessToken))
            .map(ChatResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Human 메시지 저장 실패 - 에러: \(error)")
                case .finished:
                    print("Human 메시지 저장 완료")
                }
            }, receiveValue: { [weak self] chat in

            })
            .store(in: &cancellables)
    }
    
    func saveDebateAI(roomId: Int, message: String) {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        print("AI 메시지 저장 시작")
        provider.requestPublisher(.saveDebatesAI(roomId: roomId, message: message, accessToken: accessToken))
            .map(ChatResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("AI 메시지 저장 실패 - 에러: \(error)")
                case .finished:
                    print("AI 메시지 저장 완료")
                }
            }, receiveValue: { [weak self] chat in

            })
            .store(in: &cancellables)
    }
    
    func deleteChatRoom(roomId: Int) {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        print("토론방 삭제 시작")
        provider.requestPublisher(.deleteDebatesRoom(roomId: roomId, accessToken: accessToken))
            .map(ChatResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("토론방 삭제 실패 - 에러: \(error)")
                case .finished:
                    print("토론방 삭제 완료")
                }
            }, receiveValue: { [weak self] chat in

            })
            .store(in: &cancellables)
    }
}
