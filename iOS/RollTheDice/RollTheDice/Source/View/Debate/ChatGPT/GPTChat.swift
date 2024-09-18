//
//  ChatGPTChat.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//


import Foundation

//struct GPTChat: Codable {
////    var id = UUID().uuidString
//    var title: String?
//    var messages: [Message]?
////    var id: UUID = .init() // id 속성 추가
//}
//
//struct Message: Codable, Identifiable {
//    var id: UUID = .init()
//    var content: String
//    var isUser: Bool
//}


struct DebateChat: Codable {
    let status: Int?
    let message: String?
    var data: [Message]?
}

struct Message: Codable, Identifiable {
    let id = UUID().uuidString
    let message: String?
    let senderType: SenderType?
}
