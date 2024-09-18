//
//  StatisticsAPI.swift
//  RolltheDice
//
//  Created by Subeen on 9/5/24.
//

import Foundation

public enum StatisticsAPI {
    case statisticsRecentNews   // 최근 일주일간 읽은 뉴스 조회
    case statisticsCategories   // 카테고리별 뉴스 타입 조회
    
    public var apiDesc: String {
        switch self {
        case .statisticsRecentNews:
            "/statistics/per-dates"
        case .statisticsCategories:
            "/statistics/categories"
        }
    }
}
