//
//  StatisticsListView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/3/24.
//


import SwiftUI

struct ReportListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @State private var selectedSegment = 0
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea(.all)
            
            HStack {
                Button {
                    pathModel.paths.append(.typeReportView)
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray01, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        .background(.gray07)
                        .overlay {
                            TypePieChartView(reportViewModel: TypeReportViewModel(), isPreview: true)
                        }
                        .frame(width: 400, height: 400)
                        
                }
                
                Button {
                    pathModel.paths.append(.dailyReportView)
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray01, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        .background(.gray07)
                        .overlay {
                            DailyBarChartView(dailyViewModel: DailyReportViewModel(), isPreview: true)
                                .frame(height: 200)
                        }
                        .frame(width: 400, height: 400)
                        
                }
            }
            
        }
        
    }
    
}

#Preview {
    ReportListView()
}
