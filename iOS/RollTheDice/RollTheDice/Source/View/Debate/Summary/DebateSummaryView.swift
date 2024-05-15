//
//  DebateSummaryView.swift
//  RollTheDice
//
//  Created by Subeen on 4/22/24.
//

import SwiftUI

struct DebateSummaryView: View {
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            
            VStack {
                CustomNavigationBar(title: "토론요약", isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), { pathModel.paths.popLast() })])
                
                sumView

            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var sumView: some View {
        HStack(spacing: 0) {
            Rectangle()
                .foregroundStyle(
                    LinearGradient(colors: [.gray02, .gray02, .gray04], startPoint: .leading, endPoint: .trailing)
                    
                )
                .frame(width: 88)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
            
            ZStack {
                
                UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                    .offset(x: 30, y: 20)
                    .foregroundStyle(.gray05)
                    .padding(.bottom, 20)
                Rectangle()
                    .foregroundStyle(
                        LinearGradient(colors: [.gray03, .gray02, .gray02, .gray02, .gray02, .gray02, .gray02], startPoint: .leading, endPoint: .trailing)
                        
                    )
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
                    .overlay {
                        UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                            .stroke(.gray07, lineWidth: 1.0)
                    }
                
                
            }
            // TODO: 말풍선 수정하기 
            .overlay {
                VStack(spacing: 20) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray07)
                    
                    Text("“ 이번 토론의 핵심 내용을 알려줄게요! ”")
                        .foregroundStyle(.gray07)
                        .font(.pretendardBold40)
                        .padding(.top, 40)
                    
                    HStack(alignment: .top, spacing: 0) {
                        UnevenRoundedRectangle(topLeadingRadius: 60, bottomLeadingRadius: 60, bottomTrailingRadius: 60)
                            .foregroundStyle(.gray03)
                            .overlay {
                                Text("요약")
                                    .foregroundStyle(.gray07)
                            }
                        ZStack(alignment: .topLeading) {
                            Rectangle()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.gray03)
                            Circle()
                            
                                .trim(from: 0.5, to: 1)
                                
//                                .trim(from: 0, to: 0.5)
                                .frame(width: 200, height: 200)
//                                .clipped()
                                .foregroundStyle(.gray02)
                                
                        }
                            
                        
                        Image(.scoopGray01)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 400)
                            
//                            .frame(height: 350, alignment: .top)
//                            .clipped()
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray07)
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 40)
            }
        }
        .padding(.top, 60)
        .padding(.horizontal, 110)
    }
}

#Preview {
    DebateSummaryView()
}
