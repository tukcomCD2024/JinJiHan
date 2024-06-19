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

//class GPTChatListViewModel: ObservableObject {
//    @Published var chatList: [GPTChat]
//    private var cancellables = Set<AnyCancellable>()
//    private let provider = MoyaProvider<ChatService>()
//    
//    // OpenAI API 토큰 관리
//        private let openAI: OpenAI
//    
////    // TODO: Token Hidden
////    /// token 추가해야 함
////    let openAI = OpenAI(apiToken: "")
//    
//    init(
//        topic: String,
//        chatList: [GPTChat] = [],
////            .init(title: "토론제목", messages: []),
////        ],
//        apiToken: String = "" // 깃허브 보안 이슈상으로 제거
//    ) {
////        self.chatList = chatList
//        self.chatList = chatList.isEmpty ? [GPTChat(title: topic, messages: [])] : chatList
//        self.openAI = OpenAI(apiToken: apiToken)
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
//        let messages = self.chatList[index].messages.map {
//            Chat(role: $0.isUser ? .user : .system, content: $0.content)
//        }
//        
//        //        openAI.chats(
//        //            query: .init(
//        //                model: .gpt3_5Turbo,
//        //                messages: self.chatList[index].messages.map(
//        //                    {Chat(role: .user, content: $0.content)}))
//        //        ) { result in
//        //            switch result {
//        //            case .success(let success):
//        //                guard let choice = success.choices.first else {
//        //                    return
//        //                }
//        //                let message = choice.message.content
//        //
//        //                DispatchQueue.main.async {
//        //                    self.chatList[index].messages.append(.init(content: message ?? "Error", isUser: false))
//        //                    print("gpt msg: \(self.chatList[index].messages[1])")
//        //                }
//        //
//        //            case .failure(let failure):
//        //                print(failure)
//        //            }
//        //        }
//        openAI.chats(
//            query: .init(
//                model: .gpt3_5Turbo,
//                messages: messages
//            )
//        ) { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let success):
//                guard let choice = success.choices.first else {
//                    return
//                }
//                let message = choice.message.content
//                
//                DispatchQueue.main.async {
//                    self.chatList[index].messages.append(.init(content: message ?? "Error", isUser: false))
//                    print("gpt msg: \(self.chatList[index].messages.last?.content ?? "Error")")
//                }
//                
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
//}

class GPTChatListViewModel: ObservableObject {
    @Published var chatList: [GPTChat]
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<ChatService>()
    private let debateprovider = MoyaProvider<CreateDebateRoomService>()
    private let openAI: OpenAI
    @Published var topic: String = ""
    
    init(
        topic: String,
        chatList: [GPTChat] = [],
        apiToken: String = ""
    ) {
        self.chatList = chatList.isEmpty ? [GPTChat(title: topic, messages: [])] : chatList
        self.openAI = OpenAI(apiToken: apiToken)
        
        // CreateDebateRoomService를 통해 주제를 받아와 초기 메시지를 설정
        CreateDebateRoomViewModel().createDebate(topic: topic) { debateTopic in
            let initialMessage = Message(content: "안녕하세요! 오늘의 토론 주제는 '\(debateTopic)'입니다. 이 주제에 대해 어떻게 생각하시나요?", isUser: false)
            DispatchQueue.main.async {
                self.chatList[0].messages.append(initialMessage)
            }
        }
    }

    
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
