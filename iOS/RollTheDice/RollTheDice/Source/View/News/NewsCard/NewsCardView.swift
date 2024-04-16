//
//  NewsCardView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/9/24.
//


import Foundation
import SwiftUI

struct NewsCardView: View {
    
    @State private var newsBookmarked: Bool = false
    @State private var isDetailCardNewsPresented1 = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
                .cornerRadius(30)
            
            VStack {
                
                Text("오늘의 뉴스 제목을 알려드립니다.")
                    .font(
                        Font.custom("Pretendard", size: 32)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                    .frame(width: 318, alignment: .topLeading)
                
                Text("게시일자 2024.034.09")
                    .font(
                        Font.custom("Pretendard", size: 12)
                            .weight(.bold)
                    )
                    .foregroundColor(.gray05)
                    .frame(width: 109, height: 11, alignment: .topLeading)
                    .padding(.leading,200)
                    .padding(.bottom, 15)
                
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
                    .padding(.bottom, 15)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                
                
                HStack(alignment: .top, spacing: 10) {
                    Button {
                        isDetailCardNewsPresented1 = true
                        
                    } label: {
                        Text("더보기")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(.gray01)
                        
                    }.fullScreenCover(isPresented: $isDetailCardNewsPresented1) {
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
            
        }
        .frame(width: 370, height: 440)
        .shadow(color: .basicBlack, radius: 125, x: 0, y: 0)
        .overlay {
            Button {
                newsBookmarked.toggle()
            } label: {
                Image(newsBookmarked ? "bookmarkfill" : "bookmarkunfill")
                    .resizable()
                    .frame(width: 30, height: 40)
                    .foregroundStyle(newsBookmarked ? .primary01 : .gray01)
            }
            .offset(x: 150, y: -215)
        }
        
    }
}

#Preview {
    NewsCardView()
    
}
