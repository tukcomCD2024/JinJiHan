//
//  MemberTarget.swift
//  Scoop
//
//  Created by Subeen on 9/5/24.
//

import Foundation
import Moya

enum MemberTarget {
    case getMembers(accessToken: String) // 회원 정보 조회
}

extension MemberTarget: BaseTargetType {
    var path: String {
        switch self {
        case .getMembers:
            return MemberAPI.getMembers.apiDesc
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMembers:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMembers:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {

        let token: String
            
        switch self {
        case .getMembers(let accessToken):
            
            token = accessToken
            return [
                "Authorization": "Bearer \(token)",
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}
