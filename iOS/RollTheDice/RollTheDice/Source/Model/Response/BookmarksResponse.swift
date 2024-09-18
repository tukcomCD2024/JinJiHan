//
//  Bookmark.swift
//  RollTheDice
//
//  Created by Subeen on 2/12/24.
//

import Foundation

struct Bookmarks: Codable {
    let status: Int?
    let message: String?
    let data: [BookmarksDatum]?
}

// MARK: - Datum
struct BookmarksDatum: Codable, Identifiable {
    let id = UUID().uuidString
    let newsId: Int?
    let title: String?
    let thumbnailURL: String?
    let postDate: String?
    let isBookmarked: Bool?

    enum CodingKeys: String, CodingKey {
        case newsId = "id"
        case title, thumbnailURL, postDate, isBookmarked
    }
}
