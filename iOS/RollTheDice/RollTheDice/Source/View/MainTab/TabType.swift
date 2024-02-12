//
//  TabType.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import Foundation

enum MainTabType: String, CaseIterable, CustomStringConvertible {
    case newsList
    case chat
    case bookmarkList
    case ar
    case profile
    
    var description: String {
        switch self {
        case .newsList:
            return "뉴스"
        case .chat:
            return "채팅"
        case .bookmarkList:
            return "북마크"
        case .ar:
            return "AR"
        case .profile:
            return "프로필"
        }
    }
    
    var image: String {
        switch self {
        case .newsList:
            return "newspaper"
        case .chat:
            return "message"
        case .bookmarkList:
            return "bookmarkList"
        case .ar:
            return "square.stack.3d.up.fill"
        case .profile:
            return "person.crop.circle"
        }
    }
    
    var index: Int {
        switch self {
        case .newsList:
            return .zero
        case .chat:
            return 1
        case .bookmarkList:
            return 2
        case .ar:
            return 3
        case .profile:
            return 4
        }
    }
    
}
