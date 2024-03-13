//
//  ProfileType.swift
//  RollTheDice
//
//  Created by 신예진 on 3/13/24.
//

import Foundation

enum ProfileType: String {
    case user
    case setting
    
    var name: String {
        switch self {
        case .user:
            return "user"
        case .setting:
            return "setting"
        }
    }
}
