//
//  MemberAPI.swift
//  RolltheDice
//
//  Created by Subeen on 9/5/24.
//

import Foundation

public enum MemberAPI {
    case getMembers // 회원 정보 조회
    
    public var apiDesc: String {
        switch self {
        case .getMembers:
            "members"
        }
    }
}
