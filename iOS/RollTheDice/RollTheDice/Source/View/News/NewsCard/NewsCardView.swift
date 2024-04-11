//
//  NewsCardView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/9/24.
//


import Foundation
import SwiftUI

struct NewsCardView: View {
    
    @State private var isBookmarked1: Bool = false
    
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
                        
                    } label: {
                        Text("더보기")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundColor(.gray01)
                        
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
        .shadow(color: .gray, radius: 125, x: 0, y: 0)
        //북마크 해결 필요
//        overlay {
//            Button {
//                isBookmarked1.toggle()
//            } label: {
//                Image(isBookmarked1 ? "bookmarkfill" : "bookmarkunfill")
//                    .resizable()
//                    .frame(width: 40, height: 40)
//                    .foregroundStyle(isBookmarked1 ? .primary01 : .gray01)
//            }
//            .offset(x: 140, y: -230)
//        }
        
    }
}

#Preview {
    NewsCardView()
    
}
