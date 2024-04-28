//
//  NewsReport.swift
//  RollTheDice
//
//  Created by Subeen on 4/28/24.
//

import Foundation
import SwiftUI

enum NewsType {
    case politics   // 정치
    case economy    // 경제
    case society    // 사회
    case living     // 생활/문화
    case world      // 세계
    case science    // IT/과학
    
    var desciption: String {
        switch self {
        case .politics:
            "정치"
        case .economy:
            "경제"
        case .society:
            "사회"
        case .living:
            "생활/문화"
        case .world:
            "세계"
        case .science:
            "IT/과학"
        }
    }
    
    var color: SwiftUI.Color {
        switch self {
        case .politics:
            Color.reportCyan
        case .economy:
            Color.reportGreen
        case .society:
            Color.reportPurple
        case .living:
            Color.reportYellow
        case .world:
            Color.primary01
        case .science:
            Color.reportPink
        }
    }
}
