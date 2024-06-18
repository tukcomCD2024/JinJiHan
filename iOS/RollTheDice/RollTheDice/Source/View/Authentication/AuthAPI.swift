//
//  AuthAPI.swift
//  RollTheDice
//
//  Created by 신예진 on 5/31/24.
//

import Foundation
import Moya

struct AuthProvider {
    static let provider = MoyaProvider<AuthTarget>()
}

enum AuthTarget: TargetType {
    case login(token: String)

    var baseURL: URL {
        return URL(string: "http://ec2-13-124-191-244.ap-northeast-2.compute.amazonaws.com:8080")!
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
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
        case .login(let token):
            return .requestParameters(parameters: ["accessToken": token], encoding: JSONEncoding.default)
        }
    }

//    var headers: [String: String]? {
//        return ["Content-Type": "application/json"]
//    }
    
    var headers: [String: String]? {
            var headers = [String: String]()
            if let token = TokenManager.shared.accessToken {
                headers["Authorization"] = "Bearer \(token)"
            }
            return headers
        }
}
