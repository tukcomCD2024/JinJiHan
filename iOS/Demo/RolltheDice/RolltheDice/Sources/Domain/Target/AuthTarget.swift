//
//  AuthTarget.swift
//  Scoop
//
//  Created by Subeen on 9/5/24.
//

import Foundation
import Moya

enum AuthTarget {
    case signUp(signUpRequest: SignUpRequest)
    case login(loginRequest: LoginRequest)
}

extension AuthTarget: BaseTargetType {
    var path: String {
        switch self {
        case .signUp(let signUpRequest):
            return AuthAPI.signUp.apiDesc
        case .login(let loginRequest):
            return AuthAPI.login.apiDesc
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp(_),
                .login(_):
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signUp(let signUpRequest):
            return .requestJSONEncodable(signUpRequest)
        case .login(let loginRequest):
            return .requestJSONEncodable(loginRequest)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp(_),
                .login(_):
            return [
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}
