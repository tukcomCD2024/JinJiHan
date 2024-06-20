//
//  ChatListView.swift
//  RollTheDice
//
//  Created by Subeen on 4/30/24.
//

import SwiftUI

struct ChatListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @StateObject private var newsViewModel = RecentNewsViewModel()
    @StateObject private var viewModel = DebateSummaryViewModel()
    @StateObject private var endDebateViewModel = EndDebateViewModel()
    @State private var roomId: String = "" // EndDebateViewModel로부터 받아올 roomId
    @StateObject private var getdebateroomviewModel = GetDebateRoomViewModel()
    
    
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
            //            HStack {
            //                RecentNewsCardView()
            //                Spacer()
            //                RecentNewsCardView()
            //                Spacer()
            //                RecentNewsCardView()
            //            }
            HStack {
                if newsViewModel.news.isEmpty {
                    Text("최근 읽은 뉴스를 불러오는 중...")
                        .onAppear {
                            print("뷰가 나타남 - 최근 읽은 뉴스 조회 시작")
                            newsViewModel.fetchViewedHistory()
                        }
                } else {
                    ForEach(newsViewModel.news.prefix(3), id: \.id) { news in
                        RecentNewsCardView(news: news)
                        Spacer()
                    }
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
            //            debateChatCellView
            //            debateChatCellView2
            //            debateChatCellView3
            //            debateChatCellView4
            //            debateChatCellView5
            ForEach(getdebateroomviewModel.debates) { debate in
                DebateChatCellView(debate: debate)
            }
        }
        .onAppear {
            print("채팅방 불러와짐")
            getdebateroomviewModel.fetchDebates(page: 5, size: 10)
        }
    }
    
    struct DebateChatCellView: View {
        let debate: GetDebateRoom
        let emojis = ["🏛️", "🔥", "📌", "⭐️", "🧬", "👩🏼‍💻", "🎨", "🎬", "💌", "🔗", "👀"]

        @EnvironmentObject var pathModel: PathModel
        
        var body: some View {
            let randomEmoji = emojis.randomElement() ?? "🏛️" // 이모지가 선택되지 않으면 기본값을 설정합니다.
            
            HStack {
                HStack(alignment: .center, spacing: 16) {
//                    Text("🏛️")
//                        .padding(.leading, 26)
//                        .font(.pretendardBold32)
                    Text(randomEmoji)
                        .padding(.leading, 26)
                        .font(.pretendardBold32)
                    Text(debate.topic.isEmpty ? "토론을 시작해주세요!" : debate.topic)
                        .foregroundStyle(.gray07)
                        .font(.pretendardBold24)
                        .padding(.vertical, 24)
                        
                    Spacer()
                    Button {
                        pathModel.paths.append(.chatView(isAiMode: true))
                    } label: {
                        Image(systemName: "chevronRight")
                            .foregroundColor(.gray01)
                    }
                }
                .background(.gray01)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.trailing, 16)
                
                Button {
                    pathModel.paths.append(.debateSummaryView)
                } label: {
                    Image("quote.bubble")
                        .foregroundColor(.gray01)
                        
                }
                .frame(width: 80, height: 80)
                .background(.gray01)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
//    var debateChatCellView: some View {
//        HStack {
//            HStack(alignment: .center, spacing: 16) {
//                Text("🏛️")
//                    .padding(.leading, 26)
//                    .font(.pretendardBold32)
//                Text("삼성, 갤럭시Z플립6 두뇌 전량 퀄컴칩 탑재하나")
//                    .foregroundStyle(.gray07)
//                    .font(.pretendardBold24)
//                    .padding(.vertical, 24)
//
//                Spacer()
//                Button {
//                    pathModel.paths.append(.chatView(isAiMode: true))
//                } label: {
//                    Image(systemName: "chevronRight")
//                        .foregroundColor(.gray01)
//                }
//            }
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .padding(.trailing, 16)
//
//            //TODO: 버튼 영역 수정하기
//            Button {
//                pathModel.paths.append(.debateSummaryView)
//            } label: {
//                Image("quote.bubble")
//                    .foregroundColor(.gray01)
//
//            }
//            .frame(width: 80, height: 80)
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//        }
//    }
//    var debateChatCellView2: some View {
//        HStack {
//            HStack(alignment: .center, spacing: 16) {
//                Text("📱")
//                    .padding(.leading, 26)
//                    .font(.pretendardBold32)
//                Text("모친 내친 한미약품 형제… 2644억 상속세 마련방안은 `아직`")
//                    .foregroundStyle(.gray07)
//                    .font(.pretendardBold24)
//                    .padding(.vertical, 24)
//
//                Spacer()
//                Image(.chevronRight)
//            }
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .padding(.trailing, 16)
//
//            //TODO: 버튼 영역 수정하기
//            Button {
//                pathModel.paths.append(.debateSummaryView)
//            } label: {
//                Image(.chevronLeft)
////                    .background(.gray01)
//
//            }
//            .frame(width: 80, height: 80)
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//        }
//    }
//    var debateChatCellView3: some View {
//        HStack {
//            HStack(alignment: .center, spacing: 16) {
//                Text("💌")
//                    .padding(.leading, 26)
//                    .font(.pretendardBold32)
//                Text("[ET단상]한바탕 휩쓴 방산 해킹 사건, 보안의 다른 \'답\'을 찾아야 할 때")
//                    .foregroundStyle(.gray07)
//                    .font(.pretendardBold24)
//                    .padding(.vertical, 24)
//
//                Spacer()
//                Image(.chevronRight)
//            }
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .padding(.trailing, 16)
//
//            //TODO: 버튼 영역 수정하기
//            Button {
//                pathModel.paths.append(.debateSummaryView)
//            } label: {
//                Image(.chevronLeft)
////                    .background(.gray01)
//
//            }
//            .frame(width: 80, height: 80)
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//        }
//    }
//    var debateChatCellView4: some View {
//        HStack {
//            HStack(alignment: .center, spacing: 16) {
//                Text("📱")
//                    .padding(.leading, 26)
//                    .font(.pretendardBold32)
//                Text("삼성, 갤럭시Z플립6 두뇌 전량 퀄컴칩 탑재하나")
//                    .foregroundStyle(.gray07)
//                    .font(.pretendardBold24)
//                    .padding(.vertical, 24)
//
//                Spacer()
//                Image(.chevronRight)
//            }
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .padding(.trailing, 16)
//
//            //TODO: 버튼 영역 수정하기
//            Button {
//                pathModel.paths.append(.debateSummaryView)
//            } label: {
//                Image(.chevronLeft)
////                    .background(.gray01)
//
//            }
//            .frame(width: 80, height: 80)
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//        }
//    }
//    var debateChatCellView5: some View {
//        HStack {
//            HStack(alignment: .center, spacing: 16) {
//                Text("🏛️")
//                    .padding(.leading, 26)
//                    .font(.pretendardBold32)
//                Text("삼성, 갤럭시Z플립6 두뇌 전량 퀄컴칩 탑재하나")
//                    .foregroundStyle(.gray07)
//                    .font(.pretendardBold24)
//                    .padding(.vertical, 24)
//
//                Spacer()
//                Image(.chevronRight)
//            }
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .padding(.trailing, 16)
//
//            //TODO: 버튼 영역 수정하기
//            Button {
//                pathModel.paths.append(.debateSummaryView)
//            } label: {
//                Image(systemName: "quote.bubble")
//                    .background(.gray01)
//
//            }
//            .frame(width: 80, height: 80)
//            .background(.gray01)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//        }
//    }
}

#Preview {
    ChatListView()
}
