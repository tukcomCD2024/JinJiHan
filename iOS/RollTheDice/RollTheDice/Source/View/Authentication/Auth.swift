//
//  Auth.swift
//  RollTheDice
//
//  Created by Subeen on 6/18/24.
//

import Foundation

struct AuthModel: Codable {
    let accessToken: String?
    let refreshToken: String?

//    enum CodingKeys: String, CodingKey {
//        case Authorization
//        case AuthorizationRefresh = "Authorization-refresh"
//    }
}

struct AuthRequestModel: Codable {
    let token: String?
    let socialType: String?
}
