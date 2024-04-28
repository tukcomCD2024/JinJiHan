//
//  DailyReportViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 4/28/24.
//

import Foundation

class DailyReportViewModel: ObservableObject{
    @Published var dailyViews: [DailyReport]
    
    /// 일주일 평균 조회수 
    var averageView: String {
        var aver = 0.0
        
        for daily in dailyViews {
            aver += Double(daily.views)
        }
        
        return String(format: "%.1f", aver / 7)
    }
    
    init(
        dailyViews: [DailyReport] = [
            .init(dateStr: "2024년 1월 1일", views: 32),
            .init(dateStr: "2024년 1월 2일", views: 2),
            .init(dateStr: "2024년 1월 3일", views: 300),
            .init(dateStr: "2024년 1월 4일", views: 999),
            .init(dateStr: "2024년 1월 5일", views: 12),
            .init(dateStr: "2024년 1월 6일", views: 1),
            .init(dateStr: "2024년 1월 7일", views: 99),
        ]
    ) {
        self.dailyViews = dailyViews
    }
}
