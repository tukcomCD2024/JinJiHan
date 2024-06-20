//
//  BookmarkView.swift
//  RollTheDice
//
//  Created by Subeen on 2/12/24.
//

import SwiftUI

//let id = UUID().uuidString
//let newsId: Int
//let title, thumbnailURL, postDate: String
//let isBookmarked: Bool

struct BookmarkView: View {
    @State var bookmark: Bookmarks
    var body: some View {
        ZStack {
            Color.gray07.ignoresSafeArea(.all)
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text(bookmark.title ?? "네트워크 통신 중")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.basicWhite)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 30)
                
                Spacer()

                HStack {
                    AsyncImage(url: URL(string: bookmark.thumbnailURL ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                    } placeholder: {
                        Image("photo.circle.fill")
                    }
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
//                bookmark.isBookmarked.toggle()
                
            } label: {
                Image(systemName: "bookmark.fill")

                    .resizable()
                    .frame(width: 40, height: 65)
//                    .fixedSize()
                    
                    .foregroundStyle(bookmark.isBookmarked ?? true ? .primary01 : .gray01)

            }
            .offset(x: 110, y: -130)
        }
    }
}
