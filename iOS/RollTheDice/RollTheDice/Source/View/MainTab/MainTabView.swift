//
//  MainTabView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject private var mainTabViewModel = MainTabViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea(.all)
            
            NavigationStack {
                TabView(selection: $mainTabViewModel.selectedTabItem) {
                    NewsView()
                        .tabItem {
                            Image(systemName: mainTabViewModel.selectedTabType.image)
                        }
                        .tag(0)
                    ChatView()
                        .tabItem {
                            Image(systemName: "message")
                        }
                        .tag(1)
                    BookmarkView()
                        .tabItem {
                            Image(systemName: "bookmark")
                        }
                    
                    ARView()
                        .tabItem {
                            Image(systemName: "square.stack.3d.up.fill")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                        }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
