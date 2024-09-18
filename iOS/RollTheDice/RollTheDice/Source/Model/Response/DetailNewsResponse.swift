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
    let data: DetailNewsDatum?

}

// MARK: - DataClass
struct DetailNewsDatum: Codable {
    let newsid: Int?
    let url: String?
    let title: String?
    let content: String?
    let thumbnailURL: String?
    let postDate: String?
}
