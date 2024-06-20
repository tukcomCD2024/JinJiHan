//
//  MainTabView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var pathModel: PathModel
    var newsListViewModel: NewsListViewModel
    var bookmarksListViewModel: BookmarksListViewModel
    @EnvironmentObject var authViewModel: AuthenticationViewModel
//    var recentNewsViewModel: RecentNewsViewModel
//    var debateSummaryViewModel: DebateSummaryViewModel
//    var endDebateViewModel: EndDebateViewModel
//    var getdebateroomviewModel: GetDebateRoomViewModel
//    let roomId: Int
////    @State private var roomId: Int // EndDebateViewModel로부터 받아올 roomId
    @StateObject var newsViewModel = RecentNewsViewModel()
    @StateObject var debateSummaryViewModel = DebateSummaryViewModel()
    @StateObject var endDebateViewModel = EndDebateViewModel()
    @StateObject var getdebateroomviewModel = GetDebateRoomViewModel()
    @State var roomId = 123 // 예시로 roomId 값을 할당


    @StateObject var mainTabViewModel = MainTabViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea(.all)
            VStack {
                CustomNavigationBar(
                    isDisplayTrailingBtn: true,
                    trailingItems: [
                        (Image(.bookmarkfill), { pathModel.paths.append(.bookmarkView)}),
                        (Image(.profileWhite), { pathModel.paths.append(.mypageView)})
                    ]
                )
                
                TabView(selection: $mainTabViewModel.selectedTabItem) {
                    
                    ReportListView()
                        .tabItem {
                            Image(systemName: "list.bullet.rectangle")
                        }
                        .tag(0)
                    
                    NewsListView(newsListViewModel: newsListViewModel, bookmarksViewModel: bookmarksListViewModel)
                        .tabItem {
                            Image(systemName: "square.3.layers.3d.down.left")
                        }
                    //                    .environmentObject(newsListViewModel)
                        .tag(1)
                    
                    ChatListView(
                        pathModel: _pathModel,
                                newsViewModel: newsViewModel,
                                viewModel: debateSummaryViewModel,
                                endDebateViewModel: endDebateViewModel,
                                roomId: roomId, // roomId를 Int로 전달
                                getdebateroomviewModel: getdebateroomviewModel
                            )
                            .environmentObject(pathModel)
                        .tabItem {
                            Image(systemName: "message")
                        }
                    //                    .environmentObject(pathModel)
                        .tag(2)
                    
                }
            }
        }
    }
}

#Preview {
    MainTabView(newsListViewModel: NewsListViewModel(), bookmarksListViewModel: BookmarksListViewModel())
        .environmentObject(PathModel())
//        .environmentObject(NewsListViewModel())
}
