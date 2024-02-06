//
//  TabType.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import Foundation

enum MainTabType: String, CaseIterable, CustomStringConvertible {
    case news
    case chat
    case bookmark
    case ar
    case profile
    
    var description: String {
        switch self {
        case .news:
            return "뉴스"
        case .chat:
            return "채팅"
        case .bookmark:
            return "북마크"
        case .ar:
            return "AR"
        case .profile:
            return "프로필"
        }
    }
    
    var image: String {
        switch self {
        case .news:
            return "newspaper"
        case .chat:
            return "message"
        case .bookmark:
            return "bookmark"
        case .ar:
            return "square.stack.3d.up.fill"
        case .profile:
            return "person.crop.circle"
        }
    }
    
    var index: Int {
        switch self {
        case .news:
            return .zero
        case .chat:
            return 1
        case .bookmark:
            return 2
        case .ar:
            return 3
        case .profile:
            return 4
        }
    }
    
}
