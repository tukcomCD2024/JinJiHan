//
//  StatisticsTarget.swift
//  Scoop
//
//  Created by Subeen on 9/5/24.
//

import Foundation
import Moya

enum StatisticsTarget {
    case statisticsRecentNews(accessToken: String)   // 최근 일주일간 읽은 뉴스 조회
    case statisticsCategories(accessToken: String)   // 카테고리별 뉴스 타입 조회
}

extension StatisticsTarget: BaseTargetType {
    var path: String {
        switch self {
        case .statisticsRecentNews:
            return StatisticsAPI.statisticsRecentNews.apiDesc
        case .statisticsCategories:
            return StatisticsAPI.statisticsCategories.apiDesc
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .statisticsRecentNews,
                .statisticsCategories:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .statisticsRecentNews:
            return .requestPlain
        case .statisticsCategories:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        
        let token: String
        
        switch self {
        case .statisticsRecentNews(let accessToken):
            token = accessToken
            return [
                "Authorization": "Bearer \(token)",
                "X-Content-Type_Options" : "nosniff"
            ]
            
        case .statisticsCategories(let accessToken):
            token = accessToken
            return [
                "Authorization": "Bearer \(token)",
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}

