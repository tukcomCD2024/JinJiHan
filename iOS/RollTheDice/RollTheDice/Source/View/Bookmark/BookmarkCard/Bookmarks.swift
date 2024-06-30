//
//  Bookmark.swift
//  RollTheDice
//
//  Created by Subeen on 2/12/24.
//

import Foundation


// MARK: - Bookmark
struct Bookmarks: Codable, Identifiable {
    let id = UUID().uuidString
    let newsId: Int
    let title, thumbnailURL, postDate: String?
    let isBookmarked: Bool?

    enum CodingKeys: String, CodingKey {
        case newsId = "id"
        case title, thumbnailURL, postDate, isBookmarked
    }
}


//struct Bookmarks: Hashable {
//    var id: UUID = UUID()
//    var title: String
//    var date: String
//    var image: String
//    var content: String
//    var isBookmarked: Bool
//    
//    init(
//        title: String = "",
//        date: String = "",
//        image: String = "",
//        content: String = "",
//        isBookmarked: Bool = false
//    ) {
//        self.title = title
//        self.date = date
//        self.image = image
//        self.content = content
//        self.isBookmarked = isBookmarked
//    }
//}
