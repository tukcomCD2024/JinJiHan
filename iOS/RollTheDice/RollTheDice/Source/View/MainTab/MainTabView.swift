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
                    NewsListView()
                        .tabItem {
                            Image(systemName: mainTabViewModel.selectedTabType.image)
                        }
                        .environmentObject(NewsListViewModel())
                        .tag(0)
                    ChatView()
                        .tabItem {
                            Image(systemName: "message")
                        }
                        
                        .tag(1)
                    BookmarkListView()
                        .tabItem {
                            Image(systemName: "bookmark")
                        }
                        .environmentObject(BookmarkListViewModel())
                        .tag(2)
                    ARView()
                        .tabItem {
                            Image(systemName: "square.stack.3d.up.fill")
                        }
                        .tag(3)
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                        }
                        .tag(4)
                }
                
            }
        }
    }
}

#Preview {
    MainTabView()
}
