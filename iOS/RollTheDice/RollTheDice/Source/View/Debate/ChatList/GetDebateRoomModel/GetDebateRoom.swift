//
//  GetDebateRoom.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation


struct GetDebateRoom: Identifiable, Codable {
    let id: Int
    let topic: String
    let isClosed: Bool?
}
