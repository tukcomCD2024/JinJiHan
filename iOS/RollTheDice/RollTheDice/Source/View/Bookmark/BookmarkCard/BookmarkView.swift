//
//  BookmarkView.swift
//  RollTheDice
//
//  Created by Subeen on 2/12/24.
//

import SwiftUI

struct BookmarkView: View {
    
    @State var bookmark: Bookmark
    
    var body: some View {
        ZStack {
            Color.gray07.ignoresSafeArea(.all)
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text(bookmark.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.basicWhite)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 30)
                
                Spacer()

                HStack {
                    Image(bookmark.image)
                        .frame(width: 100, height: 100)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 15)
                        )
                    Spacer()
                }
                .padding(.bottom, 30)

            }
            
            .padding(.horizontal, 30)
            
            
            
        }
        .frame(width: 300, height: 300)
        .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
        .overlay {
            Button {
                // TODO: 북마크 설정 / 해제
                bookmark.isBookmarked.toggle()
            } label: {
                Image(systemName: "bookmark.fill")

                    .resizable()
                    .frame(width: 40, height: 65)
//                    .fixedSize()
                    
                    .foregroundStyle(bookmark.isBookmarked ? .primary01 : .gray01)

            }
            .offset(x: 110, y: -130)
        }
    }
}

#Preview {
    BookmarkView(bookmark: .init(title: "2024년 ‘소셜 미디어 다이어트’를 위해 바꿔볼 것", date: "2023년12월3일", image: "exampleNews", content: "2024년으로 접어든지 한 달이 넘었다. 하지만 올 해가 어떻게 흘러갈지 예측하기는 쉽지 않다. 한 가지 확실한 것은 정치적으로 매우 중요한 해라는 점이다. 미국과 러시아, 우크라이나, 방글라데시, 인도, 대만, 한국, 남아프리카공화국, 유럽의회, 영국에서 선거가 치러질 예정이다.", isBookmarked: false))
}
