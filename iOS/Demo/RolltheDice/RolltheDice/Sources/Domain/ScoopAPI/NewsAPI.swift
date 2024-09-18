//
//  TagAPI.swift
//  RolltheDice
//
//  Created by Subeen on 9/5/24.
//

import Foundation

public enum NewsAPI {
    case getAllNews         // 요약 뉴스 전체 조회
    case getDetailNews(Int)      // 요약 뉴스 상세 조회
    
    public var apiDesc: String {
        switch self {
        case .getAllNews:
            "news"
        case .getDetailNews(let newsId):
            "news/\(newsId)"
        }
    }
}
