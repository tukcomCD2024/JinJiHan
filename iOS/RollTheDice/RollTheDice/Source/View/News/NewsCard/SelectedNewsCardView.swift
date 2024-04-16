//
//  SelectedNewsCardView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/16/24.
//


import Foundation
import SwiftUI

struct SelectedNewsCardView: View {
    
    @State private var onBookMarked: Bool = false
    @State private var isDetailCardNewsPresented = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
                .cornerRadius(30)
        
            VStack(alignment: .center, spacing: 10) {
                // pretendardBold32
                Text("북마크 선택 / 최소 1줄\n최대\n3줄?")
                  .font(
                    Font.custom("Pretendard", size: 32)
                      .weight(.bold)
                  )
                  .foregroundColor(.basicBlack)
                  .frame(width: 318, alignment: .topLeading)
                
                Text("게시일자 2090.12.12")
                  .font(
                    Font.custom("Pretendard", size: 12)
                      .weight(.bold)
                  )
                  .foregroundColor(.gray05)
                  .frame(width: 109, height: 11)
                  .offset(x: 100)
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 322, height: 159)
                  .background(
                    Image("CardSample")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 322, height: 159)
                      .clipped()
                  )
                  .cornerRadius(8)
                  .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                
                HStack(alignment: .center, spacing: 16) {
                    
                    Button {
                        isDetailCardNewsPresented = true
                        
                    } label: {
                        Text("더보기")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(.gray01)
                        
                    }.fullScreenCover(isPresented: $isDetailCardNewsPresented) {
                        // full screen으로 새로운 뷰로 네비게이션
                        DetailCardNews()
                            .frame(width: 970, height: 495)
                    }
                    
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 13)
                .background(.primary01)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
            }
            .padding(.horizontal, 24)
            .padding(.top, 50)
            .padding(.bottom, 25)
            .background(
              LinearGradient(
                stops: [
                  Gradient.Stop(color: .white, location: 0.00),
                  Gradient.Stop(color: Color(red: 1, green: 0.91, blue: 0.86), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
              )
            )
            .background(.basicWhite)
            .cornerRadius(32)
            
        }
        .frame(width: 370, height: 440)
        .shadow(color: .black, radius: 125, x: 0, y: 0)
        .overlay {
            Button {
                onBookMarked.toggle()
            } label: {
                Image(onBookMarked ? "bookmarkfill" : "bookmarkunfill")
                    .resizable()
                    .frame(width: 30, height: 40)
                    .foregroundStyle(onBookMarked ? .primary01 : .gray01)
            }
            .offset(x: 150, y: -215)
        }
        
    }
}

#Preview {
    SelectedNewsCardView()
    
}
