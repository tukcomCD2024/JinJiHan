//
//  AfterDebateView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/18/24.
//

import Foundation
import SwiftUI

struct AfterDebateView: View {
    @EnvironmentObject private var pathModel: PathModel
    @State var summaryTitle = "“ 이번 토론의 핵심 내용을 알려줄게요! ”"
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            
            // 뉴스 페이퍼
            HStack{
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 88, height: 630)
                  .background(
                    LinearGradient(
                      stops: [
                        Gradient.Stop(color: Color(red: 0.91, green: 0.91, blue: 0.91), location: 0.50),
                        Gradient.Stop(color: Color(red: 0.74, green: 0.74, blue: 0.74), location: 1.00),
                      ],
                      startPoint: UnitPoint(x: 0, y: 0.5),
                      endPoint: UnitPoint(x: 1, y: 0.5)
                    )
                  )
                  .cornerRadius(20)
                  .padding(.trailing,-3)
                
                ZStack{
                    
                    Image("paperbackground")
                      
                      .background(.gray04)
                      .cornerRadius(20)
                      .padding(.top, 30)
                    
                    
                    
                    Image("paper")
                      .padding(.trailing, 33)
                      .cornerRadius(20)
                      .shadow(color: .black.opacity(0.1), radius: 5, x: 4, y: 4)
                      .overlay(
                        Rectangle()
                          .stroke(.gray06, lineWidth: 1)
                      ).cornerRadius(20)
                }.frame(width: 930, height: 650)
                    
                
            }
            
            //뉴스페이퍼 안 내용
            VStack(spacing: 10) {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 808, height: 1)
                  .background(.black)
                  .padding(.leading, 44)
                  .padding(.top,30)
                
                Text(summaryTitle)
                  .font(
                    Font.custom("Pretendard", size: 40)
                      .weight(.bold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.basicBlack)
                  .frame(width: 631, alignment: .bottom)
                  .padding(.top, 20)
                
                HStack{
                    DebateSummaryView()
                    
                    Image("Scoop")
                      .frame(width: 196, height: 410)
                
                    
                }
                
                HStack(spacing: 10){
                    Button {
                        
                        
                    } label: {
                        Text("통계 페이지 가기")
                          .font(
                            Font.custom("Pretendard", size: 18)
                              .weight(.bold)
                          )
                          .foregroundColor(.basicWhite)
                        
                        
                    }.foregroundColor(.clear)
                        .frame(width: 364, height: 55)
                        .background(.gray05)
                        .cornerRadius(60)
                        .padding(.leading, -250)
                    
                    Button {
                        
                        
                    } label: {
                        Text("??")
                          .font(
                            Font.custom("Pretendard", size: 18)
                              .weight(.bold)
                          )
                          .foregroundColor(.basicWhite)
                        
                        
                    }.foregroundColor(.clear)
                        .frame(width: 80, height: 66)
                        .background(.primary01)
                        .cornerRadius(60)
                    
                }
                .padding(.top, -30)
                .padding(.bottom, 20)
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 808, height: 1)
                  .background(.black)
                  .padding(.leading, 44)
                  .padding(.bottom,40)
                
                
            }
            
            
        
            
        }
    }
}

#Preview {
    AfterDebateView()
        .environmentObject(PathModel())
}
