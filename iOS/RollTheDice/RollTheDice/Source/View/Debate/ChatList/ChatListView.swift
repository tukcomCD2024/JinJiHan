//
//  ChatListView.swift
//  RollTheDice
//
//  Created by Subeen on 4/30/24.
//

import SwiftUI

struct ChatListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 44) {
                    recentNewsView
                    debateChatListView
                }
                .padding(.horizontal, 120)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    var recentNewsView: some View {
        VStack(alignment: .leading) {
            Text("최근 본 뉴스")
                .foregroundStyle(.basicWhite)
                .font(.pretendardBold32)
            HStack {
                RecentNewsCardView()
                Spacer()
                RecentNewsCardView()
                Spacer()
                RecentNewsCardView()
            }
        }
    }
    
    @ViewBuilder
    var debateChatListView: some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("채팅방")
                .foregroundStyle(.basicWhite)
                .font(.pretendardBold32)
            debateChatCellView
            debateChatCellView
            debateChatCellView
        }
    }
    
    var debateChatCellView: some View {
        HStack {
            HStack(alignment: .center, spacing: 16) {
                Text("🏛️")
                    .padding(.leading, 26)
                    .font(.pretendardBold32)
                Text("경제 기사 경제 기사저제목목제목 제목")
                    .foregroundStyle(.gray07)
                    .font(.pretendardBold24)
                    .padding(.vertical, 24)
                    
                Spacer()
                Image(.chevronRight)
            }
            .background(.gray01)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 16)
            
            //TODO: 버튼 영역 수정하기
            Button {
                pathModel.paths.append(.debateSummaryView)
            } label: {
                Image(.chevronLeft)
//                    .background(.gray01)
                    
            }
            .frame(width: 80, height: 80)
            .background(.gray01)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    ChatListView()
}
