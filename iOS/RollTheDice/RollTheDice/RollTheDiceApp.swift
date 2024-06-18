//
//  RollTheDiceApp.swift
//  RollTheDice
//
//  Created by Subeen on 1/15/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct RollTheDiceApp: App {
    
    @StateObject var appState = AppState()
    @StateObject private var pathModel = PathModel()
    
    var authViewModel = AuthenticationViewModel()
    var signUpViewModel = SignUpViewModel()
    
    var newsListViewModel = NewsListViewModel()
    @StateObject var bookmarkListViewModel = BookmarksListViewModel()
    
    init() {
            KakaoSDK.initSDK(appKey: "ff09b3d83873ed4e320f0d6bc90759d6")
        }
    
    var body: some Scene {
        WindowGroup {
            
            switch authViewModel.authenticationState {
            case .unauthenticated:
                AuthenticatedView()
                    .environmentObject(authViewModel)
                
            case .authenticated:
                SignUpQuestionView()
                    .environmentObject(authViewModel)
                    .environmentObject(signUpViewModel)
            case .completedSignUp:
                NavigationStack(path: $pathModel.paths) {
                    MainTabView(newsListViewModel: newsListViewModel)
                        .navigationDestination(for: PathType.self, destination: { pathType in
                            
                            // 각 뷰마다 .navigationBarBackButtonHidden() 설정하기!
                            switch pathType {
                            case .chatView(isAiMode: true) :
                                GPTChatView()
                                    .navigationBarBackButtonHidden()
                                
                            case .chatView(isAiMode: false):
                                Text("user")
                                    .navigationBarBackButtonHidden()
                            case .detailNewsView(let newsId):
                                DetailCardNews(newsId: newsId)
                            case .typeReportView:
                                TypeReportView()
                            case .dailyReportView:
                                DailyReportView()
                            case .bookmarkView:
                                BookmarkListView(bookmarkListViewModel: bookmarkListViewModel)
                            case .mypageView:
                                Text("mypageView")
                            case .debateSummaryView:
                                DebateSummaryView()
                            case .webView(let url):
                                WebView(urlToLoad: url)
                            }
                        })
                }
                
                .environmentObject(pathModel)
                .environmentObject(authViewModel)
            }
                
            
//            if appState.hasLogin {
//                NavigationStack(path: $pathModel.paths) {
//                    MainTabView(newsListViewModel: newsListViewModel)
//                        .navigationDestination(for: PathType.self, destination: { pathType in
//                            
//                            // 각 뷰마다 .navigationBarBackButtonHidden() 설정하기!
//                            switch pathType {
//                            case .chatView(isAiMode: true) :
//                                GPTChatView()
//                                    .navigationBarBackButtonHidden()
//                                
//                            case .chatView(isAiMode: false):
//                                Text("user")
//                                    .navigationBarBackButtonHidden()
//                            case .detailNewsView(let newsId):
//                                DetailCardNews(newsId: newsId)
//                            case .typeReportView:
//                                TypeReportView()
//                            case .dailyReportView:
//                                DailyReportView()
//                            case .bookmarkView:
//                                BookmarkListView(bookmarkListViewModel: bookmarkListViewModel)
//                            case .mypageView:
//                                Text("mypageView")
//                            case .debateSummaryView:
//                                DebateSummaryView()
//                            }
//                        })
//                }
//                
//                .environmentObject(pathModel)
//                
//                
//            } else {
//                AuthenticatedView()
//                    .environmentObject(pathModel)
//            }
        }
        
    }
}



/// 로그인 상태 관리
class AppState: ObservableObject {
    
    @AppStorage("hasLogin") var hasLogin = false
    
}
