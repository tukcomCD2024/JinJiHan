//
//  StatisticsService.swift
//  RollTheDice
//
//  Created by Subeen on 6/20/24.
//

import Foundation
import Moya

enum StatisticsService {
    case recentSevenPerDate(accessToken: String) /// 최근 일주일 날짜별 뉴스 조회수 조회
    case statisticsCategory(accessToken: String)
}

extension StatisticsService: BaseTargetType {
    var baseURL: URL {
        return URL(string: ScoopAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .recentSevenPerDate(let accessToken):
            return ScoopAPIStatistics.statisticsPerDates
            
        case .statisticsCategory(let accessToken):
            return ScoopAPIStatistics.statisticsCategories
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .recentSevenPerDate,
            .statisticsCategory:
            return .get

        }
    }
    
    var task: Moya.Task {
        switch self {
        case .recentSevenPerDate(_),
                .statisticsCategory(_):
            
            let parameters : [String : Any] = [ : ]
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let accessToken: String
        
        switch self {
        case .recentSevenPerDate(let accessTokenValue),
                .statisticsCategory(let accessTokenValue):
            accessToken = accessTokenValue
            return [
                "Authorization": "Bearer \(accessToken)",
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}
