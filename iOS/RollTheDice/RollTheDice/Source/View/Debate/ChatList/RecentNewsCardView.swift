//
//  RecentNewsCardView.swift
//  RollTheDice
//
//  Created by Subeen on 4/30/24.
//

//import SwiftUI
//
//struct RecentNewsCardView: View {
//    @EnvironmentObject var pathModel: PathModel
//    @StateObject private var viewModel = CreateDebateRoomViewModel()
//    @StateObject private var newsviewModel = RecentNewsViewModel()
//    @State private var topic: String = ""
//    
//    var body: some View {
//        HStack {
//            titleView
//        }
////        .frame(width: 260, height: 244)
//        .clipShape(RoundedRectangle(cornerRadius: 8))
//    }
//    
//    var titleView: some View {
//        ZStack {
//            VStack(alignment: .center, spacing: 20) {
//                Text("📌")
//                    .font(.title)
//                Text("내 안경 못 봤어?\" 핸드폰이 알려준다…구글 \'일상 AI\' 공략 [팩플]")
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(.gray07)
//                    .font(.pretendardBold24)
//                    .frame(width: 240, height: 96)
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 30)
//                    .background(.gray01)
//                    .clipShape(RoundedRectangle(cornerRadius: 2))
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 2)
//                            .stroke(Color.gray05, lineWidth: 1.0)
//                    }
//                    .shadow(color: .basicBlack.opacity(0.1), radius: 2)
//                Button {
//                    print("버튼 클릭됨 - 주제: \(topic)")
//                    viewModel.createDebate(topic: topic)
//                    pathModel.paths.append(.createdebateroom)
//                } label: {
//                    Text("토론 시작하기")
//                        .foregroundStyle(.basicWhite)
//                        .font(.pretendardRegular14)
//                        .padding(.horizontal, 38)
//                        .padding(.vertical, 10)
//                        .background(.primary01)
//                        .clipShape(RoundedRectangle(cornerRadius: 16))
//                }
//            }
//            
//            if let debateID = viewModel.debateID {
//                Text("토론방 ID: \(debateID)")
//            }
//            
//            if let errorMessage = viewModel.errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
//            }
//        }
//        .padding(.horizontal, 20)
//        .padding(.top, 24)
//        .padding(.bottom, 32)
//        .background(.gray02)
//    }
//}
//
//#Preview {
//    RecentNewsCardView()
//}

//
//  RecentNewsCardView.swift
//  RollTheDice
//
//  Created by Subeen on 4/30/24.
//

import SwiftUI
import Combine

struct RecentNewsCardView: View {
    let news: News
    @EnvironmentObject var pathModel: PathModel
//    @StateObject private var newsViewModel = RecentNewsViewModel()
    @StateObject private var debateRoomViewModel = CreateDebateRoomViewModel()
    @State private var topic: String = ""
    
//    var body: some View {
//        VStack {
//            if let news = newsViewModel.news.first {
//                HStack {
//                    titleView(news: news)
//                }
//                .clipShape(RoundedRectangle(cornerRadius: 8))
//            } else {
//                Text("최근 읽은 뉴스를 불러오는 중...")
//                    .onAppear {
//                        print("뷰가 나타남 - 최근 읽은 뉴스 조회 시작")
//                        newsViewModel.fetchViewedHistory()
//                    }
//            }
//        }
//    }
//    
       var body: some View {
           HStack {
               titleView
           }
           .clipShape(RoundedRectangle(cornerRadius: 8))
       }
       
    
    var titleView : some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Text("📌")
                    .font(.title)
                Text(news.title)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray07)
                    .font(.pretendardBold24)
                    .frame(width: 240, height: 96)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 30)
                    .background(.gray01)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .overlay {
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.gray05, lineWidth: 1.0)
                    }
                    .shadow(color: .basicBlack.opacity(0.1), radius: 2)
                Button {
                    print("버튼 클릭됨 - 주제: \(news.title)")
                    topic = news.title
                    debateRoomViewModel.createDebate(topic: topic)
                    pathModel.paths.append(.createdebateroom)
                } label: {
                    Text("토론 시작하기")
                        .foregroundStyle(.basicWhite)
                        .font(.pretendardRegular14)
                        .padding(.horizontal, 38)
                        .padding(.vertical, 10)
                        .background(.primary01)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            
            if let debateID = debateRoomViewModel.debateID {
                Text("토론방 ID: \(debateID)")
            }
            
            if let errorMessage = debateRoomViewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 32)
        .background(.gray02)
    }
}


