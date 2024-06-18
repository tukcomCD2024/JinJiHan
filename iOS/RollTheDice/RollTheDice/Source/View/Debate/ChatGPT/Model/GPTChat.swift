//
//  ChatGPTChat.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//


import Foundation

//Mark : 원래 작성된 모델
//struct GPTChat: Hashable {
//    var title: String
//    var messages: [Message]
//    
//    init(
//        title: String = "",
//        messages: [Message] = []
//    ) {
//        self.title = title
//        self.messages = messages
//    }
//}

//struct Message: Hashable, Identifiable {
//    var id: UUID = .init()
//    var content: String
//    var isUser: Bool
//}
//
//struct Debate: Identifiable {
//    var id: Int
//    var topic: String
//    var isClosed: Bool
//}

// MARK: - Debate - Model 2
struct Debate: Codable, Hashable {
    var id: Int
    var topic: String
    var isClosed: Bool
    
    init(id: Int = 0, topic: String = "", isClosed: Bool = false) {
        self.id = id
        self.topic = topic
        self.isClosed = isClosed
    }
}

// MARK: - DebateSummary
struct DebateSummary: Codable, Hashable {
    var roomId: Int
    var summary: String
    
    init(roomId: Int = 0, summary: String = "") {
        self.roomId = roomId
        self.summary = summary
    }
}

// MARK: - Message
struct Message: Codable, Hashable {
    var message: String
    var senderType: SenderType
    
    init(message: String = "", senderType: SenderType = .human) {
        self.message = message
        self.senderType = senderType
    }
}

// MARK: - SenderType
enum SenderType: String, Codable {
    case human = "HUMAN"
    case ai = "AI"
}

// MARK: - GPTChat
struct GPTChat: Codable, Hashable {
    var title: String
    var messages: [Message]
    
    init(title: String = "채팅제목이 아직 없습니다!!", messages: [Message] = []) {
        self.title = title
        self.messages = messages
    }
}
