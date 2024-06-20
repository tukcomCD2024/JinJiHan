//
//  ChatGPTChat.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//


import Foundation

struct GPTChat: Hashable, Identifiable{
    var title: String
    var messages: [Message]
    var id: UUID = .init() // id 속성 추가
    
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

