//
//  DailyBarChartView.swift
//  RollTheDice
//
//  Created by Subeen on 4/22/24.
//


import SwiftUI
import Charts

struct DailyBarChartView: View {
    
    @State var selectedDay: Date?
    @State var selectedView: Int?
    
    var previews: [DailyViews] = [
        .init(dateStr: "1월 1일", views: 32),
        .init(dateStr: "1월 2일", views: 2),
        .init(dateStr: "1월 3일", views: 300),
        .init(dateStr: "1월 4일", views: 999),
        .init(dateStr: "1월 5일", views: 12),
        .init(dateStr: "1월 6일", views: 1),
        .init(dateStr: "1월 7일", views: 99),
    ]
    
    // TODO: 평균 기사 개수 구하는 함수 작성
    var avg: Double = 99.9
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("이번주 평균")
                        .foregroundStyle(.gray04)
                        .font(.pretendardBold12)
                    HStack {
                        Text("\(avg)")
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
                ForEach(previews) { day in
                    BarMark(
                        x: .value("Day", day.date, unit: .day),
                        y: .value("Views", day.views)
                        
                    )
                    .foregroundStyle(.orange)
                }
                
                if let selectedView = selectedView {
                    RuleMark(
//                        x: .value("Day", selectedDay!)
                        y: .value("Views", selectedView)
                    )
                    .annotation(
                        position: .top,
                        alignment: .leading,
                        overflowResolution: .init(
                            x: .fit(to: .chart),
                            y: .disabled
                        )
                    ) {
//                        Text("\(previews[selectedDay])")
                        Text("\(selectedView)")
                    }
                }
            }
            
            .padding(.horizontal, 20)
            .chartXAxis {
                AxisMarks(values: .stride(by: .day))
            }
//            .chartYAxis {
//                AxisMarks(preset: .extended, position: .leading)
//            }
            .chartYAxis(.hidden)
            .chartXSelection(value: $selectedDay)
            .chartYSelection(value: $selectedView)
//            .chartOverlay { proxy in
//                GeometryReader { geometry in
//                    Rectangle().fill(.clear).contentShape(Rectangle())
//                        .onTapGesture { value in
////                            let posX =
//                        }
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    let origin = geometry[proxy.plotFrame!].origin
//                                    let location = CGPoint(
//                                        x: value.location.x - origin.x,
//                                        y: value.location.y - origin.y
//                                    )
//                                    
//                                    selectedDay = proxy.value(atX: location.x, as: Date.self)!
//                                    let (date, view) = proxy.value(at: location, as: (Date, Int).self)!
//                                    print("Location \(date), \(view)")
//                                }
//                        )
//                    
//                }
//            }
        }
        .frame(width: 440, height: 300)
    }
}


struct DailyViews: Identifiable {
    let id = UUID()
    let dateStr: String // DateFormatter로 변환
    let views: Int
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        
        let convertedDate = dateFormatter.date(from: dateStr)!
        
        return convertedDate
    }
}


#Preview {
    DailyBarChartView()
}
