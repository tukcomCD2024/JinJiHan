//
//  NewsView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct NewsListView: View {
    
    @EnvironmentObject var newsListViewModel: NewsListViewModel
    @State var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            NewsListContentView()
                .padding(.leading, 20)
        }
    }
    
    private struct NewsListContentView: View {
        @EnvironmentObject var newsListViewModel: NewsListViewModel
        
        fileprivate var body: some View {
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(newsListViewModel.newsResponse ?? [], id: \.self) { news in
                            NewsView(news: news)
//                                .onTapGesture {
//                                    withAnimation {
//                                        selectedIndex = index
//                                        value.scrollTo(index)
//                                }
//                            }
                        }
                        .onAppear(perform: {
                            print("func fetch news")
                        })
                    }
                }
            }
            .task {
                newsListViewModel.getAllNewsData(page: 0,size: 10)
            }
        }
    }
}

#Preview {
    NewsListView()
        .previewInterfaceOrientation(.landscapeLeft)
        .environmentObject(NewsListViewModel())
}
