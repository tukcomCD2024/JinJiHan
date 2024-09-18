//
//  News.swift
//  RollTheDice
//
//  Created by Subeen on 5/16/24.
//

import Foundation


struct DetailNews: Codable {
    
    let status: Int?
    let message: String?
    let data: DetailNewsData?
    
}

struct DetailNewsData: Codable, Identifiable {
    let id: String = UUID().uuidString
    let newsId: Int?
    let url: String?
    let title: String?
    let content: String?
    let thumbnailUrl: String?
    let postDate: String?
    
    enum CodingKeys: String, CodingKey {
        case newsId = "id"
        case url, title, content, thumbnailUrl, postDate
    }
}
