//
//  DebateSum.swift
//  RollTheDice
//
//  Created by Subeen on 9/19/24.
//

import Foundation

struct DebateSum: Codable {
    let status: Int?
    let message: String?
    let data: DebateSumDatum?
}

struct DebateSumDatum: Codable {
    let roomId: Int?
    let summary: String?
}
