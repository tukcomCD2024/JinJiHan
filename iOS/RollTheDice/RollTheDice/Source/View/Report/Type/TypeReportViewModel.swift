//
//  TypeReportViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 4/21/24.
//

import Foundation

class TypeReportViewModel: ObservableObject {
    
    @Published var reportList: TypeReportList
    
    init(
        reportList: TypeReportList = .init(
            reportList: [
                .init(newsType: .economy, view: 10),
                .init(newsType: .living, view: 20),
                .init(newsType: .politics, view: 30),
                .init(newsType: .science, view: 5),
                .init(newsType: .society, view: 5),
                .init(newsType: .world, view: 30)
            ]
        )
    ) {
        self.reportList = reportList
    }
    
    // 비율이 낮은 순으로 정렬 (파이 차트에서 반시계방향으로 그래프 차지)
    var sortedList: [TypeReport] {
        return reportList.reportList.sorted { $0.view > $1.view }
    }
}
