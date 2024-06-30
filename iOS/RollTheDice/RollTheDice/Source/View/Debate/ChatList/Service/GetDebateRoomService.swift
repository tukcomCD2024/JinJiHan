//
//  GetDebateRoomService.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

//MARK : 토론방 전체 조회
import Foundation
import Moya

enum GetDebateRoomService {
    case getDebates(page: Int, size: Int)
}

extension GetDebateRoomService: TargetType {
    var baseURL: URL {
        return URL(string: "http://roll-the-dice.store:8080")!
    }
    
    var path: String {
        switch self {
        case .getDebates:
            return "/debates"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDebates:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getDebates(page, size):
            return .requestParameters(parameters: ["page": page, "size": size], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        guard let token = TokenManager.shared.accessToken else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
