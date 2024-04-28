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
    
    
    var dateToValue: (date: Date, views: Int)? {
        if let selectedDay {
            for preview in dailyViewModel.dailyViews {
                print("\(preview.date.formatted()), \(selectedDay.formatted(date: .long, time: .omitted))")
                if preview.date.formatted(date: .long, time: .omitted) == selectedDay.formatted(date: .long, time: .omitted) {
                    return (selectedDay, preview.views)
                }
            }
        }
        return nil
    }
    
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
            
            Spacer()
                .frame(height: 100)
            
            Chart{
                ForEach(dailyViewModel.dailyViews) { day in
                    BarMark(
                        x: .value("Day", day.date, unit: .weekdayOrdinal),
                        y: .value("Views", day.views)
                        
                    )
                    .foregroundStyle(.orange)
                }
                
                if let selectedDay = selectedDay {
                    if dateToValue != nil {
                        
                        RuleMark(
                            x: .value("Day", selectedDay, unit: .day)
                        )
                        .annotation(
                            position: .top,
                            alignment: .centerLastTextBaseline,
                            overflowResolution: .init(
                                x: .fit(to: .chart),
                                y: .disabled
                            )
                        ) {
                            popoverView
                        }
                        .foregroundStyle(.basicWhite)
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 7))
            }
            .chartYAxis(.hidden)
            .chartXSelection(value: $selectedDay)
        }
    }
    
    @ViewBuilder
    var popoverView: some View {
        VStack(alignment: .center) {
            Text("\(dateToValue?.date.formatted(date: .numeric, time: .omitted) ?? "")")
                .font(.pretendardRegular14)
            Text("\(dateToValue?.views ?? 0)")
                .font(.pretendardBold32)

        }
        .padding(10)
        .background(.gray06)
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray05, lineWidth: 1.0)
        }
    }
}

#Preview {
    DailyBarChartView(dailyViewModel: DailyReportViewModel())
}
