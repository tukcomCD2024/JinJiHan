//
//  SummaryDebate.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation

struct SummaryDebate: Identifiable, Codable {
    let id = UUID()
    let roomId : Int?
    let summary: String?
}
