// API Test
//
//
//
//
//import Foundation
//
//// MARK: - NewsElement
//struct News: Codable, Hashable {
//    let id: Int
//    let title, content: String
//    let thumbnail: JSONNull?
//    let postDate: String
//    let isBookmarked: Bool
//}
//
//typealias NewsResponse = [News]
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}







// ========

//
//  NewsCard.swift
//  RollTheDice
//
//  Created by Subeen on 2/9/24.
//

import Foundation

struct News: Hashable {
    var id: UUID = UUID()
    var title: String
    var postDate: String
    var image: String
    var content: String
    var isBookmarked: Bool
    
    init(
        title: String = "",
        postDate: String = "",
        image: String = "",
        content: String = "",
        isBookmarked: Bool = false
    ) {
        self.title = title
        self.postDate = postDate
        self.image = image
        self.content = content
        self.isBookmarked = isBookmarked
    }
}
