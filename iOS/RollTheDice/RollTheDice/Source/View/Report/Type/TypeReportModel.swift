//
//  TypeReport.swift
//  RollTheDice
//
//  Created by Subeen on 4/21/24.
//

import Foundation

struct TypeReport {
    var typeReportList: [[NewsType : Double]]
}

enum NewsType {
    case politics   // 정치
    case economy    // 경제
    case society    // 사회
    case living     // 생활/문화
    case world      // 세계
    case science    // IT/과학
}
