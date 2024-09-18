//
//  AuthRequestModel.swift
//  RollTheDice
//
//  Created by Subeen on 9/18/24.
//

import Foundation

struct AuthRequestModel: Codable {
    let token: String?
    let socialType: String?
}


struct SignUpRequest: Codable {
    let email: String?
    let memberUpdateDto: MemberUpdateDto?
}

struct MemberUpdateDto: Codable {
    let nickname: String?
}
