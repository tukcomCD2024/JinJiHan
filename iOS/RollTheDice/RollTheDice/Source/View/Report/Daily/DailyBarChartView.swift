//
//  DailyBarChartView.swift
//  RollTheDice
//
//  Created by Subeen on 4/22/24.
//


import SwiftUI
import Charts

struct DailyBarChartView: View {
    
    @StateObject var dailyViewModel: DailyReportViewModel
    
    @State var selectedDay: Date?
    @State var selectedView: Int?
    
    
    var dateToView: Int? {
        if let selectedDay {
            for preview in dailyViewModel.dailyViews {
                print("\(preview.date.formatted()), \(selectedDay.formatted(date: .long, time: .omitted))")
                if preview.date.formatted(date: .long, time: .omitted) == selectedDay.formatted(date: .long, time: .omitted) {
                    return preview.views
                }
            }
        }
        return nil
    }
    
    // TODO: 평균 기사 개수 구하는 함수 작성
//    var avg: Double = 99.9
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("이번주 평균")
                        .foregroundStyle(.gray04)
                        .font(.pretendardBold12)
                    HStack {
                        Text(dailyViewModel.averageView)
                            .foregroundStyle(.basicWhite)
                            .font(.pretendardBold40)
                        Text("기사")
                            .foregroundStyle(.gray04)
                            .font(.pretendardBold12)
                    }
                }
                Spacer()
            }
            
            Chart{
                ForEach(dailyViewModel.dailyViews) { day in
                    BarMark(
                        x: .value("Day", day.date, unit: .weekdayOrdinal),
                        y: .value("Views", day.views)
                        
                    )
                    .foregroundStyle(.orange)
                }
                
                if let selectedDay = selectedDay {
                        
                    RuleMark(
                        x: .value("Day", selectedDay, unit: .day)
                    )
                    .annotation(
                        position: .top,
                        alignment: .leading,
                        overflowResolution: .init(
                            x: .fit(to: .chart),
                            y: .disabled
                        )
                    ) {
                        
                        Text("\(dateToView ?? -1)")
                    }
                    .foregroundStyle(.basicWhite)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 7))
            }
            .chartYAxis(.hidden)
            .chartXSelection(value: $selectedDay)
        }
        .frame(width: 440, height: 300)
    }
}

#Preview {
    DailyBarChartView(dailyViewModel: DailyReportViewModel())
}
