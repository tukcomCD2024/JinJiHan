//
//  TypePieChartView.swift
//  RollTheDice
//
//  Created by Subeen on 4/28/24.
//

import SwiftUI
import Charts

struct TypePieChartView: View {
    
    @StateObject var reportViewModel: TypeReportViewModel
    
    var body: some View {
        Chart(reportViewModel.sortedList) { report in
            SectorMark(
                angle: .value("Views", report.view),
                innerRadius: .ratio(0.618),
                angularInset: 2.0
            )
            .cornerRadius(8)
            .foregroundStyle(report.newsType.color)
        }
    }
}

#Preview {
    TypePieChartView(reportViewModel: TypeReportViewModel())
}
