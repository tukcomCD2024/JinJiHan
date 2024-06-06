//
//  ChatGPTChat.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//


import Foundation

struct GPTChat: Hashable {
    var title: String
    var messages: [Message]
    
    init(
        title: String = "",
        messages: [Message] = []
    ) {
        self.title = title
        self.messages = messages
    }
}

struct Message: Hashable, Identifiable {
    var id: UUID = .init()
    var content: String
    var isUser: Bool
}


