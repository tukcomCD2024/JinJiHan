//
//  GetDebateRoom.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation

// MARK: - DebateChat
struct DebateChat: Codable {
    let status: Int?
    let message: String?
    let data: [DebateChatDatum]?
}

struct DebateChatDatum: Codable, Identifiable {
    let id = UUID().uuidString
    let roomId: Int?
    let topic: String?
    let isClosed: Bool?

    enum CodingKeys: String, CodingKey {
        case roomId = "id"
        case topic, isClosed
    }
}
