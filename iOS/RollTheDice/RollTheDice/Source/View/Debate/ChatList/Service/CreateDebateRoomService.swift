//
//  CreateDebateRoomService.swift
//  RollTheDice
//
//  Created by 신예진 on 6/19/24.
//

import Foundation
import Moya

enum CreateDebateRoomService {
    case createDebate(topic: String)
}

extension CreateDebateRoomService: TargetType {
    var baseURL: URL {
        return URL(string: "http://roll-the-dice.store:8080")!
    }

    var path: String {
        switch self {
        case .createDebate:
            return "/debates"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createDebate:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .createDebate(let topic):
            let parameters: [String: Any] = ["topic": topic]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
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
