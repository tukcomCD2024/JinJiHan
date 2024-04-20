//
//  MainTabView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var pathModel: PathModel
    @StateObject var newsListViewModel: NewsListViewModel
    
    @StateObject var mainTabViewModel = MainTabViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundDark
                .ignoresSafeArea(.all)
            
            TabView(selection: $mainTabViewModel.selectedTabItem) {
                
                StatisticsListView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle")
                    }
                    .tag(0)
                
                NewsListView(newsListViewModel: newsListViewModel)
                    .tabItem {
                        Image(systemName: "square.3.layers.3d.down.left")
                    }
                    .environmentObject(newsListViewModel)
                    .tag(1)
                
                ChatTypeView()
                    .tabItem {
                        Image(systemName: "message")
                    }
                    .tag(2)

            }
        }
    
    }
}

#Preview {
    MainTabView(newsListViewModel: NewsListViewModel())
        .environmentObject(NewsListViewModel())
}
