//
//  AuthAPI.swift
//  RolltheDice
//
//  Created by Subeen on 9/5/24.
//

import Foundation

public enum AuthAPI {
    case signUp
    case login
    
    public var apiDesc: String {
        switch self {
        case .signUp:
            return "/oauth2/sign-up"
        case .login:
            return "/login"
        }
    }
}
