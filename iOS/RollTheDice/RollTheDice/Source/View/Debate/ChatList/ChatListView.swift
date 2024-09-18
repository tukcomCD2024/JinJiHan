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
    
    
    @StateObject private var viewModel = DebateSummaryViewModel()
    @StateObject private var endDebateViewModel = EndDebateViewModel()
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
                debateViewModel.getDebates(page: 1, size: 3)
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
            ForEach(debateViewModel.debateChatRoom?.data ?? []) { debate in
                DebateChatCellView(debate: debate)
            }
        }
    }
}

#Preview {
    ChatListView()
}
