//
//  ScoopAPIDebate.swift
//  RollTheDice
//
//  Created by Subeen on 9/19/24.
//

import Foundation

public enum ScoopAPIDebate {
    case getDebates
    case createDebates
    case saveDebatesHuman(Int)   // [인간] 토론 메세지 저장
    case saveDebatesAI(Int)      // [AI] 토론 메세지 저장
    case getDebatesSum(Int)
    case sumDebates(Int)
    case getDebatesMsg(Int)
    case deleteDebatesRoom(Int)
    case endDebatesRoom(Int)
    
    public var apiDesc: String {
        switch self {
        case .getDebates:
            "/debates"
        case .createDebates:
            "/debates"
        case .saveDebatesHuman(let roomId):
            "/debates/\(roomId)/human"
        case .saveDebatesAI(let roomId):
            "/debates/\(roomId)/ai"
        case .getDebatesSum(let roomId):
            "/debates/summary/\(roomId)"
        case .sumDebates(let roomId):
            "/debates/summary/\(roomId)"
        case .getDebatesMsg(let roomId):
            "/debates/\(roomId)"
        case .deleteDebatesRoom(let roomId):
            "/debates/\(roomId)"
        case .endDebatesRoom(let roomId):
            "/debates/\(roomId)"
        }
    }
}
