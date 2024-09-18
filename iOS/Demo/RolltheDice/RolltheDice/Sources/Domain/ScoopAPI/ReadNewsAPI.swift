//
//  ReadNewsAPI.swift
//  RolltheDice
//
//  Created by Subeen on 9/5/24.
//

import Foundation

public enum ReadNewsAPI {
    case readNewsHistory    // 최근 읽은 뉴스 조회
    
    public var apiDesc: String {
        switch self {
        case .readNewsHistory:
            "/read-news/viewed-history"
        }
    }
}
