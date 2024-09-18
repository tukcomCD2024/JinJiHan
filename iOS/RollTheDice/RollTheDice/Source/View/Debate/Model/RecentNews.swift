//
//  News.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation

struct RecentNews: Codable {
    let status: Int?
    let message: String?
    let data: [RecentNewsDatum]?
}

struct RecentNewsDatum: Codable, Identifiable {
    let id = UUID().uuidString
    let newsId: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case newsId = "id"
        case title = "title"
    }
}
