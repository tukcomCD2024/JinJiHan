//
//  PathType.swift
//  RollTheDice
//
//  Created by Subeen on 3/10/24.
//

import Foundation

enum PathType: Hashable {
    case chatView(isAiMode: Bool)
    case detailNewsView
    case typeReportView     // 분야별 뉴스 통계
    case dailyReportView    // 요일별 뉴스 관람 개수 통계
}
