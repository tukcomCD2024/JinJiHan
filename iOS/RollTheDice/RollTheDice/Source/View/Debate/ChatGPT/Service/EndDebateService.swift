//
//  EndDebateService.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation
import Moya

enum EndDebateService {
    case endDebate(roomId: String)
}

extension EndDebateService: TargetType {
    var baseURL: URL {
        return URL(string: "http://roll-the-dice.store:8080")!
    }
    
    var path: String {
        switch self {
        case .endDebate(let roomId):
            return "/debates/\(roomId)"
        }
    }
    
    var method: Moya.Method {
        return .patch
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        guard let token = TokenManager.shared.accessToken else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
