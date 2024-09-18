//
//  ChatType.swift
//  RollTheDice
//
//  Created by Subeen on 2/14/24.
//

import Foundation

enum SenderType: String, Codable {
    case ai = "AI"
    case human = "HUMAN"
    
    var description: String {
        switch self {
        case .ai:
            "AI"
        case .human:
            "HUMAN"
        }
    }
    
    var name: String {
        switch self {
        case .ai:
            return "AI"
        case .human:
            return "HUMAN"
        }
    }
}
