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
    
    
    var selectedValue: (date: Date, views: Int)? {
        if let selectedDay {
            for preview in dailyViewModel.dailyReportList.reportList {
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
                ForEach(dailyViewModel.dailyReportList.reportList) { day in
                    BarMark(
                        x: .value("Day", day.date, unit: .weekdayOrdinal),
                        y: .value("Views", day.views)
                        
                    )
                    .cornerRadius(8)
                    .foregroundStyle(.primary01.gradient)
//                    .foregroundStyle(selectedValue?.date.formatted(date: .abbreviated, time: .omitted) == selectedDay?.formatted(date: .abbreviated, time: .omitted) ? .orange : .blue)
                    //TODO: 바 선택 / 미선택에 따른 막대 투명도 조절
                    .opacity(selectedValue?.date == nil || selectedValue?.date.formatted(date: .numeric, time: .omitted) == selectedDay?.formatted(date: .numeric, time: .omitted) ? 1 : 0.5)
                }
                
                if let selectedDay = selectedDay {
                    if selectedValue != nil {
                        
                        RuleMark(
                            x: .value("Day", selectedDay, unit: .day)
                        )
                        .zIndex(-1)
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
            Text("\(selectedValue?.date.formatted(date: .numeric, time: .omitted) ?? "")")
                .font(.pretendardRegular14)
            Text("\(selectedValue?.views ?? 0)")
                .font(.pretendardBold24)

        }
        .padding(10)
        .background(.gray06.gradient)
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
