//
//  GetDebateRoom.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation

// MARK: - DebateChat
struct DebateRoom: Codable {
    let status: Int?
    let message: String?
    let data: [DebateRoomDatum]?
}

struct DebateRoomDatum: Codable, Identifiable {
    let id = UUID().uuidString
    let roomId: Int?
    let topic: String?
    let isClosed: Bool?

    enum CodingKeys: String, CodingKey {
        case roomId = "id"
        case topic, isClosed
    }
}
