//
//  DailyReportView.swift
//  RollTheDice
//
//  Created by Subeen on 4/22/24.
//

import SwiftUI


struct DailyReportView: View {
    
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            
            VStack {
                /// 내비게이션 뒤로가기 
                CustomNavigationBar(isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), {pathModel.paths.popLast()})])
                
                Spacer()
                
                HStack {
                    statisticsView
                    reportView 
                }
                .frame(height: 500)
                .padding(.horizontal, 110)
                
                Spacer()
            }
            
        }
    }
    

    /// 데일리 막대 그래프
    var statisticsView: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(.basicWhite, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            .background(.gray07)
            .overlay {
                DailyBarChartView(dailyViewModel: DailyReportViewModel())
                    .padding(50)
            }
    }
    
    // TODO : 배치 바꾸기!!
    /// 상단 막대 + 분야별 뉴스 통계 박스 + 통계 글 + 캐릭터
    /// 하단 막대
    /// 각각 묶어서 ZStack에 배치하기
    var reportView: some View {
        RoundedRectangle(cornerRadius: 16)
            .foregroundStyle(.gray02)
            .overlay {
                ZStack {
                    VStack {
                        Rectangle()
                            .frame(height: 1)
                        

                        Rectangle()
                            .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            .frame(height: 52)
                            .overlay {
                                Text("요일별 뉴스 관람 개수 통계")
                                    .font(.pretendardBold24)
                                    .foregroundStyle(.gray06)
                            }
                            .padding(.vertical, 20)
                        
                        
                        HStack {
                            Text("안녕하세요. 이것은 통계입니다. 안녕하세요. 이것은 통계입니다. ")
                                .multilineTextAlignment(.leading)
                                
                            Spacer()
                        }
                        .padding(.horizontal, 4)
                        
                        Spacer()
                        
                        Rectangle()
                            .frame(height: 1)
                    }
                    .padding(.vertical, 34)
                    .padding(.horizontal, 24)
                    .foregroundStyle(.gray06)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Image(.scoopGray04)
                                .aspectRatio(0.5, contentMode: .fill)
                                .frame(height: 250, alignment: .top)
                                .clipped()
                        }
                    }
                }
            }
    }
}

#Preview {
    DailyReportView()
}
