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
                    AsyncImage(url: URL(string: bookmark.image)) { image in
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
    BookmarkView(bookmark: .init(title: "NHN, 작년 영업익 555억원...전년비 42% ↑", date: "2023년2월13일", image: "https://cdnimage.dailian.co.kr/news/202402/news_1707866329_1327972_m_1.png", content: "2NHN은 연결기준 지난해 영업이익이 555억원으로 전년 대비 42.2% 증가했다고 14일 밝혔다.같은 기간 매출은 7.3% 증가한 2조2696억원으로 연간 최대치를 기록했다. 작년 4분기 매출은 5983억원으로 전년 동기 대비 6.7% 올랐다. 반면 영업손실은 78억원으로 적자전환했다. 커머스 부문의 장기 미회수채권 대손상각비 인식과 기술 부문의 기 인식 매출 차감 등 일회성 요인이 영향을 미쳤다.", isBookmarked: false))
}
