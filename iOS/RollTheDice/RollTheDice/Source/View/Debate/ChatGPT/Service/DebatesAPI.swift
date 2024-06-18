//
//  DebatesAPI.swift
//  RollTheDice
//
//  Created by 신예진 on 6/18/24.
//

import Foundation
import Moya


enum DebatesAPI {
    case getAllDebates(page: Int, size: Int, sort: String)
    case createDebate(topic: String)
    case getDebateSummary(roomId: Int)
    case summarizeDebate(roomId: Int)
    case deleteDebate(roomId: Int)
    case closeDebate(roomId: Int)
    case saveHumanMessage(roomId: Int, message: String)
    case saveAIMessage(roomId: Int, message: String)
    case getDebateMessages(roomId: Int)
}

extension DebatesAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://roll-the-dice.store:8080")! //Swagger 링크 바뀌었는데 이거 맞을까?
    }
    
    var path: String {
        switch self {
        case .getAllDebates:
            return "/debates"
        case .createDebate:
            return "/debates"
        case .getDebateSummary(let roomId), .summarizeDebate(let roomId), .deleteDebate(let roomId), .closeDebate(let roomId), .getDebateMessages(let roomId):
            return "/debates/\(roomId)"
        case .saveHumanMessage(let roomId, _):
            return "/debates/\(roomId)/human"
        case .saveAIMessage(let roomId, _):
            return "/debates/\(roomId)/ai"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllDebates, .getDebateSummary, .getDebateMessages:
            return .get
        case .createDebate, .saveHumanMessage, .saveAIMessage:
            return .post
        case .summarizeDebate:
            return .patch
        case .deleteDebate, .closeDebate:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getAllDebates(let page, let size, let sort):
            return .requestParameters(parameters: ["page": page, "size": size, "sort": sort], encoding: URLEncoding.queryString)
        case .createDebate(let topic):
            return .requestJSONEncodable(["topic": topic])
        case .saveHumanMessage(_, let message), .saveAIMessage(_, let message):
            return .requestJSONEncodable(["message": message])
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Authorization": "Bearer YOUR_TOKEN", "Content-Type": "application/json"]
    }
}
