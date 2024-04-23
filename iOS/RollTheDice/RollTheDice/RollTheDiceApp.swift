//
//  RollTheDiceApp.swift
//  RollTheDice
//
//  Created by Subeen on 1/15/24.
//

import SwiftUI

@main
struct RollTheDiceApp: App {
    
    @StateObject var appState = AppState()
    @StateObject private var pathModel = PathModel()
    
    @StateObject var newsListViewModel = NewsListViewModel()
    @StateObject var bookmarkListViewModel = BookmarkListViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            if appState.hasLogin {
                NavigationStack(path: $pathModel.paths) {
                    MainTabView(newsListViewModel: newsListViewModel)
                        .navigationDestination(for: PathType.self, destination: { pathType in
                            
                            switch pathType {
                            case .chatView(isAiMode: true) :
                                GPTChatView()
                                    .navigationBarBackButtonHidden()
                                
                            case .chatView(isAiMode: false):
                                Text("user")
                                    .navigationBarBackButtonHidden()
                            case .detailNewsView:
                                DetailCardNews()
                            case .typeReportView:
                                TypeReportView()
                            case .dailyReportView:
                                DailyReportView()
                            case .bookmarkView:
                                BookmarkListView(bookmarkListViewModel: bookmarkListViewModel)
                            case .mypageView:
                                Text("mypageView")
                            }
                        })
                }
                .navigationBarBackButtonHidden()
                .environmentObject(pathModel)
                
                
            } else {
                SignUpView()
            }
        }
        
    }
}

/// 로그인 상태 관리
class AppState: ObservableObject {
    
    @AppStorage("hasLogin") var hasLogin = true
}
