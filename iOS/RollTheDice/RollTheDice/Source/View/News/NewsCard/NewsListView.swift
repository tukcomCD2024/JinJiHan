//
//  NewsView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct NewsListView: View {
    
    var newsListViewModel: NewsListViewModel
    var newsId: Int?
    @State var selectedIndex: Int = 0

    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            
            
            GeometryReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(newsListViewModel.newsList ?? []) { news in
                            
                            NewsView(news: news)
                                .frame(width: proxy.size.width)
                                .scrollTransition(.interactive, axis: .horizontal) { effect, phase in
                                    effect
                                        .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                        .blur(radius: phase.isIdentity ? 0 : 1)
//                                        .offset(x: offset(for: phase))
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
//            NewsListContentView(newsList: $newsListViewModel.newsList)
//                .padding(.leading, 20)
        }
        .task {
            newsListViewModel.getAllNewsData(page: 0, size: 10)
        }
    }
    
    func offset (for phase: ScrollTransitionPhase) -> Double {
        switch phase {
        case .topLeading:
            700
        case .identity:
            0
        case .bottomTrailing:
            -700
        }
    }
    
//    private struct NewsListContentView: View {
//        @Binding var newsList: [News]
//        
//       
//        
//        fileprivate var body: some View {
//            GeometryReader { proxy in
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHStack {
//                        ForEach(newsList , id: \.self) { news in
//                            
//                            NewsView(news: news)
//                                .frame(width: proxy.size.width)
//                                .scrollTransition(.interactive, axis: .horizontal) { effect, phase in
//                                    effect
//                                        .scaleEffect(phase.isIdentity ? 1 : 0.8)
//                                        .blur(radius: phase.isIdentity ? 0 : 1)
//                                        .offset(x: offset(for: phase))
//                                }
//                        }
//                    }
//                    .scrollTargetLayout()
//                }
//                .scrollTargetBehavior(.viewAligned)
//            }
            
//        }
        
//        func offset (for phase: ScrollTransitionPhase) -> Double {
//            switch phase {
//            case .topLeading:
//                700
//            case .identity:
//                0
//            case .bottomTrailing:
//                -700
//            }
//        }
//    }
}

#Preview {
    NewsListView(newsListViewModel: NewsListViewModel())
        .previewInterfaceOrientation(.landscapeLeft)
}
