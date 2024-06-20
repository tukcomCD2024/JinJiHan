//
//  DebateSummaryService.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation
import Moya

enum DebateSummaryService {
    case getSummary(roomId: Int)
}

extension DebateSummaryService: TargetType {
    var baseURL: URL {
        return URL(string: "http://roll-the-dice.store:8080")!
    }
    
    var path: String {
        switch self {
        case .getSummary(let roomId):
            return "/debates/summary/\(roomId)"
        }
    }
    
    var method: Moya.Method {
        return .post
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
