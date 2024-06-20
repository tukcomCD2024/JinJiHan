//
//  NewsCardView.swift
//  RollTheDice
//
//  Created by Subeen on 2/9/24.
//

import SwiftUI

struct NewsView: View {
    
    @EnvironmentObject var pathModel : PathModel

    var news: NewsList
    var bookmarksViewModel: BookmarksListViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text(news.title ?? "")
                    .font(.pretendardBold32)
                    .foregroundStyle(.basicBlack)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            HStack {
                Spacer()
                Text(news.postDate ?? "")
                    .font(.pretendardBold12)
                    .foregroundStyle(.gray05)
            }
            
            
            AsyncImage(url: URL(string: news.thumbnailUrl ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 322, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)

                @unknown default:
                    Text("");
                }
                
            }
        
            Button {
                let newsId:Int = news.newsId
                pathModel.paths.append(.detailNewsView(newsId: newsId))
            } label: {
                Text("더보기")
                    .font(.pretendardBold14)
                    .foregroundStyle(.gray01)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 13)
                    .background(.primary01)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )
                    .shadow(color: .basicBlack.opacity(0.25), radius: 2, x: 0, y: 0)
                
            }
                
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 25)
        .padding(.top, 50)
        .frame(width: 380)
        .background(
                LinearGradient(colors: [.basicWhite, .primaryLight01], startPoint: .top, endPoint: .bottom)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            // TODO : 북마크 버튼 위치 수정하기
            VStack {
                HStack {
                    Spacer()
                    Button {
                        if news.isBookmarked ?? false {
                            
                        } else {
                            
                        }
                    } label: {
                        Image(news.isBookmarked ?? false ? .bookmarkfill : .bookmarkunfill)
                            .shadow(color: .gray06, radius: 2)
                    }
                    .offset(CGSize(width: -20, height: -10))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    NewsView(news: .init(newsId: 1, title: "1분기 선방한 dddddddd韓게임사들…엔씨만 울었다", content: "내용내용ㄴㅇㅇㅇ", thumbnailUrl: "", postDate: "2222-22-22", isBookmarked: true), bookmarksViewModel: BookmarksListViewModel())
        .environmentObject(PathModel())
}
