//
//  ChatResponse.swift
//  RollTheDice
//
//  Created by Subeen on 9/19/24.
//

import Foundation

struct ChatResponse: Codable {
    let status: Int?
    let message: String?
    let data: String?
}
