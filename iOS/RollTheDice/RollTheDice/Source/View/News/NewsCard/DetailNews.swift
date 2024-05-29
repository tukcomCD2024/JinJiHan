//
//  News.swift
//  RollTheDice
//
//  Created by Subeen on 5/16/24.
//

import Foundation


struct DetailNews: Codable, Identifiable {
    let id: Int?
    let url: String?
    let title: String?
    let content: String?
    let thumbnailUrl: String?
    let postDate: String?

}
