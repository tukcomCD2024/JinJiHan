//
//  MainTabView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var newsListViewModel: NewsListViewModel
    
    @StateObject private var mainTabViewModel = MainTabViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea(.all)
            
            TabView(selection: $mainTabViewModel.selectedTabItem) {
                NewsListView()
                    .tabItem {
                        Image(systemName: "newspaper")
                    }
                    .environmentObject(newsListViewModel)
                    .tag(0)
                ChatTypeView()
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

#Preview {
    MainTabView()
        .environmentObject(NewsListViewModel())
}
