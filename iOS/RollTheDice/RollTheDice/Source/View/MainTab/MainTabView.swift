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
                    
                    ChatListView()
                    //                    .environmentObject(pathModel)
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
