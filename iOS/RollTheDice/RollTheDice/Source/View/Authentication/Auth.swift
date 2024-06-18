//
//  Auth.swift
//  RollTheDice
//
//  Created by Subeen on 6/18/24.
//

import Foundation

struct AuthModel {
    let Authorization: String?
    let AuthorizationRefresh: String?

    enum CodingKeys: String, CodingKey {
        case Authorization
        case AuthorizationRefresh = "Authorization-refresh"
    }
}
