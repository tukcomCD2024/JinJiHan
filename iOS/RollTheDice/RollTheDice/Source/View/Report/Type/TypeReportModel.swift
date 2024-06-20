//
//  TypeReport.swift
//  RollTheDice
//
//  Created by Subeen on 4/21/24.
//

import Foundation

struct TypeReport: Codable, Identifiable {
    
    let id = UUID().uuidString
    let category: NewsType?
    let views: Int?
}
