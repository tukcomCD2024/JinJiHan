//
//  GPTChatListViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

//import Foundation
//import OpenAI
//
//class GPTChatListViewModel: ObservableObject {
//    @Published var chatList: [GPTChat]
//
//    // TODO: Token Hidden
//    /// token 추가해야 함
//    let openAI = OpenAI(apiToken: "")
//
//    init(
//        chatList: [GPTChat] = [
//            .init(title: "111111111", messages: []),
//        ]
//    ) {
//        self.chatList = chatList
//    }
//}
//
//extension GPTChatListViewModel {
//    /// OpenAI
//    func sendNewMessage(index: Int, content: String) {
//        print("call sendNewMessage func")
//
//        let userMessage = Message(content: content, isUser: true)
//        self.chatList[index].messages.append(userMessage)
//
//        getBotReply(index: index)
//    }
//
//    func getBotReply(index: Int) {
//        print("call getBotReply func")
//
//        openAI.chats(
//            query: .init(
//                model: .gpt3_5Turbo,
//                messages: self.chatList[index].messages.map(
//                    {Chat(role: .user, content: $0.content)}))
//        ) { result in
//            switch result {
//            case .success(let success):
//                guard let choice = success.choices.first else {
//                    return
//                }
//                let message = choice.message.content
//
//                DispatchQueue.main.async {
//                    self.chatList[index].messages.append(.init(content: message ?? "Error", isUser: false))
//                    print("gpt msg: \(self.chatList[index].messages[1])")
//                }
//
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
//}

import Foundation
import Moya
import Combine

class GPTChatListViewModel: ObservableObject {
    @Published var chatList: [GPTChat]
    private var cancellables = Set<AnyCancellable>()
    
    private let provider = MoyaProvider<GPTAPI>()
    
    init(
        chatList: [GPTChat] = [
            .init(title: "111111111", messages: []),
        ]
    ) {
        self.chatList = chatList
    }
    
    func sendNewMessage(index: Int, content: String) {
        print("sendNewMessage called with content: \(content)")
        let userMessage = Message(content: content, isUser: true)
        self.chatList[index].messages.append(userMessage)
        print("User message appended: \(userMessage)")
        
        // roomId는 실제 토론방 ID로 설정
        let roomId = 1
        provider.requestPublisher(.sendUserMessage(roomId: roomId, message: content))
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error sending user message: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                print("User message sent successfully: \(response)")
                // 성공적으로 메시지가 전송된 후, AI 응답 가져오기
                self.getBotReply(index: index, content: content, roomId: roomId)
            })
            .store(in: &cancellables)
    }
    
    private func getBotReply(index: Int, content: String, roomId: Int) {
        print("getBotReply called with content: \(content)")

        provider.requestPublisher(.sendAIMessage(roomId: roomId, message: content))
            .map { response -> String in
                let responseString = try? response.mapString()
                return responseString ?? "Error"
            }
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error sending AI message: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] message in
                guard let self = self else { return }
                print("Received bot message: \(message)")
                let botMessage = Message(content: message, isUser: false)
                DispatchQueue.main.async {
                    self.chatList[index].messages.append(botMessage)
                }
            })
            .store(in: &cancellables)
    }
}
