//
//  ChatListView.swift
//  RollTheDice
//
//  Created by Subeen on 4/30/24.
//

import SwiftUI

struct ChatListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @StateObject var debateViewModel = DebateRoomViewModel()
    @StateObject private var recentNewsViewModel = RecentNewsViewModel()
    
        let emojis = ["🏛️", "🔥", "📌", "⭐️", "🧬", "👩🏼‍💻", "🎨", "🎬", "💌", "🔗", "👀"]
    
//    @StateObject private var viewModel = DebateSummaryViewModel()
    @State private var roomId: String = "" // EndDebateViewModel로부터 받아올 roomId
    
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
            .onAppear {
                recentNewsViewModel.fetchViewedHistory()
                debateViewModel.getDebates(page: 1, size: 2)
            }
        }
    }
    
    @ViewBuilder
    var recentNewsView: some View {
        VStack(alignment: .leading) {
            Text("최근 본 뉴스")
                .foregroundStyle(.basicWhite)
                .font(.pretendardBold32)

            HStack {
                ForEach(recentNewsViewModel.recentNews?.data ?? []) { news in
                    RecentNewsCardView(news: news, debateViewModel: debateViewModel)
                        Spacer()
                }
                
            }
            .padding()
        }
    }
    
    @ViewBuilder
    var debateChatListView: some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("채팅방")
                .foregroundStyle(.basicWhite)
                .font(.pretendardBold32)
            ForEach(debateViewModel.debateRoom?.data ?? []) { debate in
                debateChatCellView(debate: debate)
                    
            }
        }
    }
    
    @ViewBuilder
    func debateChatCellView(debate: DebateRoomDatum) -> some View {
        let randomEmoji = emojis.randomElement() ?? "🏛️" // 이모지가 선택되지 않으면 기본값을 설정합니다.
        
        HStack {
            HStack(alignment: .center, spacing: 16) {
                Text(randomEmoji)
                    .padding(.leading, 26)
                    .font(.pretendardBold32)
                Text(debate.topic ?? "")
                    .foregroundStyle(.gray07)
                    .font(.pretendardBold24)
                    .padding(.vertical, 24)
                    
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray01)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 16)
            .onTapGesture {
                pathModel.paths.append(.chatView(topic: debate.topic ?? "", roomId: debate.roomId ?? 1))
                print("\(debate.roomId)")
            }
            
            Button {
                print("요약 페이지 버튼 누름")
                pathModel.paths.append(.debateSummaryView(roomId: debate.roomId ?? 1))
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.gray01)
                    .overlay {
                        Image(.chevronRight)
                            .foregroundStyle(.primary01)
                    }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    ChatListView()
}
