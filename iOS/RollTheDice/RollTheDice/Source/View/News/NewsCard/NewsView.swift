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
                    Text(news.postDate)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.gray05)
                }
                
                Spacer()
                    .frame(height: 10)
                
//                Text("Image")
                AsyncImage(url: URL(string: news.title)) { image in
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
//                news.isBookmarked.toggle()
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
//
//#Preview(traits: .sizeThatFitsLayout) {
//    NewsView()
//        .previewInterfaceOrientation(.landscapeLeft)
//        .previewLayout(.sizeThatFits)
//}
