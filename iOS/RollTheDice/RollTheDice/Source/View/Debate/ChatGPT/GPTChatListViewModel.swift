//
//  GPTChatListViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import Foundation
import OpenAI
import Combine
import Moya

class GPTChatListViewModel: ObservableObject {
    @Published var chatList: [GPTChat]
    private var cancellables = Set<AnyCancellable>()
        private let provider = MoyaProvider<ChatService>()
    
    // OpenAI API 토큰 관리
        private let openAI: OpenAI
    
//    // TODO: Token Hidden
//    /// token 추가해야 함
//    let openAI = OpenAI(apiToken: "")
    
    init(
        chatList: [GPTChat] = [
            .init(title: "토론제목", messages: []),
        ],
        apiToken: String = "" // TokenManager를 통해 API 토큰을 관리
    ) {
        self.chatList = chatList
        self.openAI = OpenAI(apiToken: apiToken)
    }
}

extension GPTChatListViewModel {
    /// OpenAI
    func sendNewMessage(index: Int, content: String) {
        print("call sendNewMessage func")
        
        let userMessage = Message(content: content, isUser: true)
        self.chatList[index].messages.append(userMessage)
        
        getBotReply(index: index)
    }
    
    func getBotReply(index: Int) {
        print("call getBotReply func")
        
        let messages = self.chatList[index].messages.map {
            Chat(role: $0.isUser ? .user : .system, content: $0.content)
        }
        
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
        openAI.chats(
            query: .init(
                model: .gpt3_5Turbo,
                messages: messages
            )
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                guard let choice = success.choices.first else {
                    return
                }
                let message = choice.message.content
                
                DispatchQueue.main.async {
                    self.chatList[index].messages.append(.init(content: message ?? "Error", isUser: false))
                    print("gpt msg: \(self.chatList[index].messages.last?.content ?? "Error")")
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
