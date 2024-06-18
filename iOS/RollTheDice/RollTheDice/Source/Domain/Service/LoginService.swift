//
//  AuthAPI.swift
//  RollTheDice
//
//  Created by 신예진 on 5/31/24.
//

import Foundation
import Moya

enum LoginService {
    case login(token: String, socialType: String)
}

//struct LoginService {
//    static let provider = MoyaProvider<AuthTarget>()
//}

extension LoginService: BaseTargetType {

    var baseURL: URL {
        return URL(string: ScoopAPI.baseURL)!
    }

    var path: String {
        switch self {
        case .login:
            return ScoopAPILogin.login
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .login(let token, let socialType):
            let parameters : [String : Any] = [
                "token" : token,
                "socialType" : socialType,
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return [
            "X-Content-Type_Options" : "nosniff"
        ]
    }
}
