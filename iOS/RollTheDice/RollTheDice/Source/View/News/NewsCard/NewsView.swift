//
//  NewsCardView.swift
//  RollTheDice
//
//  Created by Subeen on 2/9/24.
//

import SwiftUI

struct NewsView: View {
    
    @State var news: News
    
    var body: some View {
        ZStack {
            Color.gray07.ignoresSafeArea(.all)
            
            
            VStack(spacing: 0) {
                Text(news.title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.basicWhite)
                    .padding(.top, 50)
                HStack {
                    Spacer()
//                        .frame(height: 10)
                    Text(news.date)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.gray05)
                }
                
                Spacer()
                    .frame(height: 10)
                AsyncImage(url: URL(string: news.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxHeight: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                } placeholder: {
                    Image("photo.circle.fill")
                }
                
                Spacer()
                    .frame(height: 30)
                
                Text(news.content)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.basicWhite)
                Spacer()
            }
            
            .padding(.horizontal, 40)
            
            
            
        }
        .frame(width: 400, height: 510)
        .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
        .overlay {
            Button {
                // TODO: 북마크 설정 / 해제
                news.isBookmarked.toggle()
            } label: {
                Image(systemName: "bookmark.fill")

                    .resizable()
                    .frame(width: 40, height: 65)
//                    .fixedSize()
                    
                    .foregroundStyle(news.isBookmarked ? .primary01 : .gray01)

            }
            .offset(x: 140, y: -230)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NewsView(news: .init(title: "2024년 ‘소셜 미디어 다이어트’를 위해 바꿔볼 것", date: "2023년12월3일", image: "https://imgnews.pstatic.net/image/008/2024/03/05/0005007355_001_20240305100101016.jpg?type=w647", content: "2024년으로 접어든지 한 달이 넘었다. 하지만 올 해가 어떻게 흘러갈지 예측하기는 쉽지 않다. 한 가지 확실한 것은 정치적으로 매우 중요한 해라는 점이다. 미국과 러시아, 우크라이나, 방글라데시, 인도, 대만, 한국, 남아프리카공화국, 유럽의회, 영국에서 선거가 치러질 예정이다.", isBookmarked: false))
        .previewInterfaceOrientation(.landscapeLeft)
        .previewLayout(.sizeThatFits)
}
