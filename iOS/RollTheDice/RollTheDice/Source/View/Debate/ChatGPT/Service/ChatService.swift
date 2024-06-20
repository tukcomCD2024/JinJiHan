//
//  ChatService.swift
//  RollTheDice
//
//  Created by 신예진 on 6/19/24.
//

import Foundation
import Moya

enum ChatService {
    case sendMessageToAI(roomId: Int, message: String)
    case sendMessageToHuman(roomId: Int, message: String)
}

extension ChatService: TargetType {
    var baseURL: URL {
        return URL(string: "http://roll-the-dice.store:8080")!
    }

    var path: String {
        switch self {
        case .sendMessageToAI(let roomId, _):
            return "/debates/\(roomId)/ai"
        case .sendMessageToHuman(let roomId, _):
            return "/debates/\(roomId)/human"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .sendMessageToAI(_, let message), .sendMessageToHuman(_, let message):
            return .requestParameters(parameters: ["message": message], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        guard let token = TokenManager.shared.accessToken else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }
}
