//
//  TypeReportViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 4/21/24.
//

import Foundation

class TypeReportViewModel: ObservableObject {
    @Published var typeReportList: TypeReport
    
    init(
        typeReportList: TypeReport = .init(
            typeReportList: [
                [NewsType.economy : 10.0],
                [NewsType.living : 20.0],
                [NewsType.politics : 30.0],
                [NewsType.science : 5.0],
                [NewsType.society : 5.0],
                [NewsType.world : 30.0],
            ]
        )
    ) {
        self.typeReportList = typeReportList
    }
}
