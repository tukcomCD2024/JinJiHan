//
//  GPTAPI.swift
//  RollTheDice
//
//  Created by 신예진 on 6/6/24.
//

//import Foundation
//import Moya
//
//enum GPTAPI {
//    case sendMessage(content: String)
//}
//
//extension GPTAPI: TargetType {
//    var baseURL: URL {
//        return URL(string: "http://ec2-13-124-191-244.ap-northeast-2.compute.amazonaws.com:8080")!
//    }
//    
//    var path: String {
//        switch self {
//        case .sendMessage:
//            return "/debates/{roomId}"
//        }
//    }
//    
//    var method: Moya.Method {
//        switch self {
//        case .sendMessage:
//            return .post
//        }
//    }
//    
//    var task: Task {
//        switch self {
//        case let .sendMessage(content):
//            return .requestParameters(parameters: ["message": content], encoding: JSONEncoding.default)
//        }
//    }
//    
//    var headers: [String: String]? {
//        return ["Content-Type": "application/json"]
//    }
//    
//    var sampleData: Data {
//        switch self {
//        case .sendMessage:
//            return Data()
//        }
//    }
//}
import Foundation
import Moya

enum GPTAPI {
    case sendUserMessage(roomId: Int, message: String)
    case sendAIMessage(roomId: Int, message: String)
}

extension GPTAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://ec2-13-124-191-244.ap-northeast-2.compute.amazonaws.com:8080")!
    }
    
    var path: String {
        switch self {
        case .sendUserMessage(let roomId, _):
            return "/debates/\(roomId)/human"
        case .sendAIMessage(let roomId, _):
            return "/debates/\(roomId)/ai"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendUserMessage, .sendAIMessage:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .sendUserMessage(_, let message), .sendAIMessage(_, let message):
            return .requestParameters(parameters: ["message": message], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
