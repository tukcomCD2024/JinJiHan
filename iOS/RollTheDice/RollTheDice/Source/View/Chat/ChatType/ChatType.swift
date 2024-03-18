//
//  ChatType.swift
//  RollTheDice
//
//  Created by Subeen on 2/14/24.
//

import Foundation

enum ChatType: String {
    case ai
    case user
    
    var name: String {
        switch self {
        case .ai:
            return "ai"
        case .user:
            return "user"
        }
    }
}
