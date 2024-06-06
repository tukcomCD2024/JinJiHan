//
//  PathType.swift
//  RollTheDice
//
//  Created by Subeen on 3/10/24.
//

import Foundation

enum PathType: Hashable {
    case chatView(isAiMode: Bool)
    case detailNewsView(newsId: Int)     // 뉴스 자세히 보기
    
    case typeReportView     // 분야별 뉴스 통계
    case dailyReportView    // 요일별 뉴스 관람 개수 통계
    
    case debateSummaryView  // 토론 요약 페이지 뷰
    
    case bookmarkView       // 북마크뷰
    case mypageView         // 마이페이지뷰
    
    case webView(url: String)
    
    case gptChatView
}
