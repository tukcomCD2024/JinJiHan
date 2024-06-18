////
////  GPTChatListViewModel.swift
////  RollTheDice
////
////  Created by Subeen on 3/20/24.
////
//
//import Foundation
//import OpenAI
//import Combine
//import Moya
//
//class GPTChatListViewModel: ObservableObject {
//    @Published var chatList: [GPTChat]
//    private var cancellables = Set<AnyCancellable>()
//
//    let openAIProvider = MoyaProvider<OpenAIAPI>()
//    
//    // TODO: Token Hidden
//    /// token 추가해야 함 - Accesstoken??
//    let openAI = OpenAI(apiToken: "\()")
//    
//    init(
//        chatList: [GPTChat] = [
//            .init(title: "토론제목", messages: []),
//        ]
//    ) {
//        self.chatList = chatList
//        
//    }
//    
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
//        openAIProvider.request(.sendMessage(messages: messages)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let success = try JSONDecoder().decode(OpenAIResponse.self, from: response.data)
//                    guard let choice = success.choices.first else {
//                        return
//                    }
//                    let message = choice.message.content
//                    
//                    DispatchQueue.main.async {
//                        self.chatList[index].messages.append(.init(content: message ?? "Error", isUser: false))
//                        print("gpt msg: \(self.chatList[index].messages.last?.content ?? "Error")")
//                    }
//                } catch {
//                    print("Failed to decode response: \(error.localizedDescription)")
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
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
