//
//  DebateTarget.swift
//  RollTheDice
//
//  Created by Subeen on 9/19/24.
//

import Foundation
import Moya

enum DebateService {
    case getDebates(page: Int, size: Int, accessToken: String)                        //  토론방 전체 조회
    case createDebates(topic: String, accessToken: String)
    case saveDebatesHuman(roomId: Int, message: String, accessToken: String)   // [인간] 토론 메세지 저장
    case saveDebatesAI(roomId: Int, message: String, accessToken: String)      // [AI] 토론 메세지 저장
    case getDebatesSum(roomId: Int, accessToken: String)
    case sumDebates(roomId: Int, accessToken: String)
    case getDebatesMsg(roomId: Int, accessToken: String)
    case deleteDebatesRoom(roomId: Int, accessToken: String)
    case endDebatesRoom(roomId: Int, accessToken: String)
}

extension DebateService: BaseTargetType {
    var path: String {
        switch self {
        case .getDebates(_, _, _):
            return ScoopAPIDebate.getDebates.apiDesc
            
        case .createDebates(_, _):
            return ScoopAPIDebate.createDebates.apiDesc
            
        case .saveDebatesHuman(let roomId, _, _):
            return ScoopAPIDebate.saveDebatesHuman(roomId).apiDesc
            
        case .saveDebatesAI(let roomId, _, _):
            return ScoopAPIDebate.saveDebatesAI(roomId).apiDesc
            
        case .getDebatesSum(let roomId, _):
            return ScoopAPIDebate.getDebatesSum(roomId).apiDesc
            
        case .sumDebates(let roomId, _):
            return ScoopAPIDebate.sumDebates(roomId).apiDesc
            
        case .getDebatesMsg(let roomId, _):
            return ScoopAPIDebate.getDebatesMsg(roomId).apiDesc
            
        case .deleteDebatesRoom(let roomId, _):
            return ScoopAPIDebate.deleteDebatesRoom(roomId).apiDesc
            
        case .endDebatesRoom(let roomId, _):
            return ScoopAPIDebate.endDebatesRoom(roomId).apiDesc
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDebates:
            return .get
            
        case .createDebates:
            return .post
            
        case .saveDebatesHuman:
            return .post
            
        case .saveDebatesAI:
            return .post
            
        case .getDebatesSum:
            return .get
            
        case .sumDebates:
            return .post
            
        case .getDebatesMsg:
            return .get
            
        case .deleteDebatesRoom:
            return .delete
            
        case .endDebatesRoom:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getDebates(let page, let size, _):
            let parameters : [String : Any] = [
                "page" : page,
                "size" : size
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .createDebates(let topic, _):
            let parameters : [String : Any] = [
                "topic" : topic
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .saveDebatesHuman(_, let message, _):
            let parameters : [String : Any] = [
                "message" : message
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .saveDebatesAI(_, let message, _):
            let parameters : [String : Any] = [
                "message" : message
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .getDebatesSum:
            return .requestPlain
            
        case .sumDebates:
            return .requestPlain
            
        case .getDebatesMsg:
            return .requestPlain
            
        case .deleteDebatesRoom:
            return .requestPlain
            
        case .endDebatesRoom:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {

        let token: String
            
        switch self {

        case .getDebates(_, _, let accessToken),
        .createDebates(_, let accessToken),
        .saveDebatesHuman(_, _, let accessToken),
        .saveDebatesAI(_, _, let accessToken),
        .getDebatesSum(_, let accessToken),
        .sumDebates(_, let accessToken),
        .getDebatesMsg(_, let accessToken),
        .deleteDebatesRoom(_, let accessToken),
        .endDebatesRoom(_, let accessToken):
            token = accessToken
            return [
                "Authorization": "Bearer \(token)",
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}

