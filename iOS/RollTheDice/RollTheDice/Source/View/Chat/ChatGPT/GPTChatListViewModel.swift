//
//  GPTChatListViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import Foundation
import OpenAI

class GPTChatListViewModel: ObservableObject {
    @Published var chatList: [GPTChat]
    
    // TODO: Token Hidden
    /// token 추가해야 함
    let openAI = OpenAI(apiToken: "")
    
    init(
        chatList: [GPTChat] = [
            .init(title: "111111111", messages: []),
        ]
    ) {
        self.chatList = chatList
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
        
        openAI.chats(
            query: .init(
                model: .gpt3_5Turbo,
                messages: self.chatList[index].messages.map(
                    {Chat(role: .user, content: $0.content)}))
        ) { result in
            switch result {
            case .success(let success):
                guard let choice = success.choices.first else {
                    return
                }
                let message = choice.message.content
                
                DispatchQueue.main.async {
                    self.chatList[index].messages.append(.init(content: message ?? "Error", isUser: false))
                    print("gpt msg: \(self.chatList[index].messages[1])")
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
