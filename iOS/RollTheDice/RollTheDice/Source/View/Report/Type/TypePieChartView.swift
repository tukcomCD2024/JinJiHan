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
    
    var isPreview: Bool = false
    
    var mostViewed: NewsType {
        return reportViewModel.sortedList.first!.newsType
    }
    
    var body: some View {
        Chart(reportViewModel.sortedList) { report in
            SectorMark(
                angle: .value("Views", report.view),
                innerRadius: .ratio(0.7),
                angularInset: 2.0
            )
            .cornerRadius(8)
            .foregroundStyle(report.newsType.color.gradient)
        }
        /// pie chart의 가운데 문구
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                
                if !isPreview {
                    VStack {
                        Text("많이 본 분야")
                            .foregroundStyle(.gray05)
                            .font(.pretendardRegular14)
                        Text(mostViewed.desciption)
                            .foregroundStyle(.gray01)
                            .font(.pretendardBold24)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
            }
        }
        .padding(100)
    }
}

#Preview {
    TypePieChartView(reportViewModel: TypeReportViewModel())
}
