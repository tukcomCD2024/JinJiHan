//
//  NewsSerivce.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
//

import Foundation
import Combine
import CombineMoya
import Moya

protocol NewsSerivceType {
    func getAllNews(page: Int, size: Int) async throws -> NewsList
    func getDetailNews(newsId: Int) async throws -> DetailNews
}

class NewsSerivce: NewsSerivceType {
    func getAllNews(page: Int, size: Int) async throws -> NewsList {
        return .init(status: 1, message: "", data: [])
    }
    
    func getDetailNews(newsId: Int) async throws -> DetailNews {
        return .init(status: 1, message: "", data: nil)
    }
}
