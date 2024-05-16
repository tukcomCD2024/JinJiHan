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
            
            NewsListContentView(newsList: newsListViewModel.newsList ?? [])
        }
        .task {
            newsListViewModel.getAllNewsData(page: 0, size: 10)
        }
    }
    
    private struct NewsListContentView: View {
        var newsList: [NewsList]
        
       
        
        fileprivate var body: some View {
            GeometryReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: -234567876455aa0) {
                        ForEach(newsList) { news in
                            
                            NewsView(news: news)
                                .frame(width: proxy.size.width)
                                .scrollTransition(.interactive, axis: .horizontal) { effect, phase in
                                    effect
                                        .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                        .blur(radius: phase.isIdentity ? 0 : 1)
                                        .grayscale(phase.isIdentity ? 0 : 0.7)
                                        .offset(x: offset(for: phase, width: proxy.size.width))
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
            
        }
        
        func offset (for phase: ScrollTransitionPhase, width: CGFloat) -> Double {
            var calculatedSize: CGFloat
            switch phase {
            case .topLeading:
                calculatedSize = width / 1.5
            case .identity:
                calculatedSize = 0
            case .bottomTrailing:
                calculatedSize = -(width / 1.5)
            }
            return calculatedSize
        }
    }
}

#Preview {
    NewsListView(newsListViewModel: NewsListViewModel())
        .previewInterfaceOrientation(.landscapeLeft)
}
