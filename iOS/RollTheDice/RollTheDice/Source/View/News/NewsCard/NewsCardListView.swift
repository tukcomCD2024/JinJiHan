//
//  NewsCardListView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/4/24.
//

import Foundation
import SwiftUI

struct NewsCardListView: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0

    private let newsCards: [AnyView] = [
        AnyView(SelectedNewsCardView()),
        AnyView(NewsCardView()),
        AnyView(NewsCardView()),
        AnyView(NewsCardView()),
        AnyView(NewsCardView()),
        AnyView(NewsCardView()),
        AnyView(NewsCardView()),
        AnyView(NewsCardView()),
        AnyView(NewsCardView()),
        AnyView(NewsCardView())
    ]
    
    var body: some View {
        
        NavigationStack {
            VStack {
                ZStack {
                    Color.backgroundDark.ignoresSafeArea(.all)
                    
                    Rectangle()
                      .foregroundColor(.primary01)
                      .frame(width: UIScreen.main.bounds.width, height: 80)
                      .offset(y:-430)
                
                    ForEach(0..<newsCards.count, id: \.self) { index in
                        if currentIndex == index {
                            SelectedNewsCardView()
                                .frame(width: 370, height: 500)
                                .cornerRadius(25)
                                .opacity(1.0)
                                .scaleEffect(1.2)
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 0.5))
                                .zIndex(1)
                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                        } else {
                            NewsCardView()
                                .frame(width: 370, height: 440)
                                .cornerRadius(25)
                                .opacity(0.5)
                                .scaleEffect(0.8)
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 0.5))
                                .zIndex(0)
                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                        }
                    }
                }
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, dragOffset, _ in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold: CGFloat = 50
                            let translation = value.translation.width
                            
                            if translation > threshold {
                                withAnimation(.easeInOut) {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if translation < -threshold {
                                withAnimation(.easeInOut) {
                                    currentIndex = min(newsCards.count - 1, currentIndex + 1)
                                }
                            }
                        }
                )
                
            }
            .navigationTitle("카드 뉴스")
            .font(.headline)
            .foregroundColor(.primary01)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Button {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(.primary01)
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                currentIndex = min(newsCards.count - 1, currentIndex + 1)
                            }
                        } label: {
                            Image(systemName: "arrow.right")
                                .font(.title)
                                .foregroundColor(.primary01)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("카드 뉴스")
                    .font(.headline)
                    .foregroundColor(.primary01)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(action: {
                                // First button action
                            }) {
                                Image("bookmarkfill")
                                    .font(.title)
                                    .foregroundColor(.primary01)
                            }
                            
                            Button(action: {
                                // Second button action
                            }) {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundColor(.primary01)
                            }
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle()) // 스택 네비게이션 뷰 스타일 적용
                }
}


#Preview {
    NewsCardListView()
    
}
