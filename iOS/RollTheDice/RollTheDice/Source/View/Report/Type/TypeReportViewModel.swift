//
//  TypeReportViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 4/21/24.
//

import Foundation

class TypeReportViewModel: ObservableObject {
    
    @Published var typeReportList: TypeReportList
    
    init(
        typeReportList: TypeReportList = .init(
            reportList: [
                .init(typeReportList: .economy, view: 10),
                .init(typeReportList: .living, view: 20),
                .init(typeReportList: .politics, view: 30),
                .init(typeReportList: .science, view: 5),
                .init(typeReportList: .society, view: 5),
                .init(typeReportList: .world, view: 30)
            ]
        )
    ) {
        self.typeReportList = typeReportList
    }
    
    // 비율이 낮은순으로 정렬 (파이 차트에서 반시계방향으로 그래프 차지)
    var sortedList: [TypeReport] {
        return typeReportList.reportList.sorted { $0.view < $1.view }
    }
}
