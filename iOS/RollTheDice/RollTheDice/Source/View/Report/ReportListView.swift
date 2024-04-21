//
//  StatisticsListView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/3/24.
//


import SwiftUI

struct ReportListView: View {
    
    @State private var selectedSegment = 0
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea(.all)
            
            VStack {
                HStack(spacing: 0) {
                    ForEach(0 ..< 2) { index in
                        Text(index == 0 ? "분야별 레포트" : "일별 레포트")
                            .bold()
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(selectedSegment == index ? .white : .primary01)
                            .background(selectedSegment == index ? Color.primary01 : .clear)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedSegment = index
                            }
                            .tag(index)
                    }
                }
                .padding(.leading, 200)
                .padding(.trailing, 200)
                .padding(.top,10)
                
                Spacer()
                
                if selectedSegment == 0 {
                    TypeReportView()
                } else if selectedSegment == 1 {
                    DailyReportView()
                }
                
                
                Spacer()
            }
            .padding()
            
        }
        
    }
    
}

#Preview {
    ReportListView()
}
