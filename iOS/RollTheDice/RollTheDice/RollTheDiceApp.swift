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
    
    var body: some Scene {
        WindowGroup {
            
            if appState.hasLogin {
                NavigationStack(path: $pathModel.paths) {
                    MainTabView()
                        .environmentObject(newsListViewModel)
                        .navigationDestination(for: PathType.self, destination: { pathType in
                            
                            switch pathType {
                            case .chatView(isAiMode: true) :
                                AIChatView()
                                    .navigationBarBackButtonHidden()
                                
                            case .chatView(isAiMode: false):
                                Text("user")
                                    .navigationBarBackButtonHidden()
                            }
                        })
                }
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
