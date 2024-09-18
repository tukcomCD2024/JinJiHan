//
//  TypeReport.swift
//  RollTheDice
//
//  Created by Subeen on 4/21/24.
//

import Foundation

struct TypeReport: Codable {
    let status: Int?
    let message: String?
    let data: [TypeReportDatum]?
}

// MARK: - Datum
struct TypeReportDatum: Codable, Identifiable {
    let id = UUID().uuidString
    let views: Int?
    let category: String?
}
