//
//  NewsCardListView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/4/24.
//

import Foundation
import SwiftUI

//struct NewsCardListView: View {
//    
//    @State private var currentIndex: Int = 0
//    @GestureState private var dragOffset: CGFloat = 0
//    
//    private let newsCards: [AnyView] = [
//        AnyView(SelectedNewsCardView()),
//        AnyView(NewsCardView()),
//        AnyView(NewsCardView()),
//        AnyView(NewsCardView()),
//        AnyView(NewsCardView()),
//        AnyView(NewsCardView()),
//        AnyView(NewsCardView()),
//        AnyView(NewsCardView()),
//        AnyView(NewsCardView()),
//        AnyView(NewsCardView())
//    ]
//    
//    var body: some View {
//        
//        NavigationStack {
//            ZStack {
//                
//                Color.backgroundDark.ignoresSafeArea(.all)
//                
//                ZStack {
//                    
//                    
//                    Spacer()
//                    
//                    ForEach(0..<newsCards.count, id: \.self) { index in
//                        if currentIndex == index {
//                            SelectedNewsCardView()
//                                .frame(width: 370, height: 500)
//                                .cornerRadius(25)
//                                .opacity(1.0)
//                                .scaleEffect(1.2)
//                                .transition(.opacity)
//                                .animation(.easeInOut(duration: 0.5))
//                                .zIndex(1)
//                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
//                        } else {
//                            NewsCardView()
//                                .frame(width: 370, height: 440)
//                                .cornerRadius(25)
//                                .opacity(0.5)
//                                .scaleEffect(0.8)
//                                .transition(.opacity)
//                                .animation(.easeInOut(duration: 0.5))
//                                .zIndex(0)
//                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
//                        }
//                    }
//                }
//                .gesture(
//                    DragGesture()
//                        .updating($dragOffset) { value, dragOffset, _ in
//                            dragOffset = value.translation.width
//                        }
//                        .onEnded { value in
//                            let threshold: CGFloat = 50
//                            let translation = value.translation.width
//                            
//                            if translation > threshold {
//                                withAnimation(.easeInOut) {
//                                    currentIndex = max(0, currentIndex - 1)
//                                }
//                            } else if translation < -threshold {
//                                withAnimation(.easeInOut) {
//                                    currentIndex = min(newsCards.count - 1, currentIndex + 1)
//                                }
//                            }
//                        }
//                )
//                
//            }
//            
//        }
//        .navigationTitle("카드 뉴스")
//        .font(.headline)
//        .foregroundColor(.primary01)
//        .toolbar {
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                Button(action: {
//                    // First button action
//                }) {
//                    Image("bookmarkfill")
//                        .font(.title)
//                        .foregroundColor(.primary01)
//                }
//                
//                Button(action: {
//                    // Second button action
//                }) {
//                    Image(systemName: "person.fill")
//                        .font(.title)
//                        .foregroundColor(.primary01)
//                }
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle()) // 스택 네비게이션 뷰 스타일 적용
//    }
//}

// 북마크, person 그거까지 뜨는데 , TITLE이 안 뜨고 스크롤이 너무 부자연스러움.
struct NewsCardListView: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isBookMarkTabbed = false
    @State private var isProfileTabbed = false
    
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
        NavigationView { // NavigationView로 래핑
            ZStack {
                Color.backgroundDark.ignoresSafeArea(.all)
                
                ZStack {
                    Spacer()
                    
                    ForEach(0..<newsCards.count, id: \.self) { index in
                        if currentIndex == index {
                            SelectedNewsCardView()
                                .frame(width: 370, height: 500)
                                .cornerRadius(25)
                                .opacity(1.0)
                                .scaleEffect(1.2)
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 0.3))
                                .zIndex(1)
                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                        } else {
                            NewsCardView()
                                .frame(width: 370, height: 440)
                                .cornerRadius(25)
                                .opacity(0.5)
                                .scaleEffect(0.8)
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 0.3))
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
            .foregroundColor(.white)
            .toolbar {
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isBookMarkTabbed = true
                    }) {
                        Image("bookmarkfill")
                            .font(.title)
                            .foregroundColor(.primary01)
                            .frame(width: 10, height: 30)
                            .padding(.trailing, 10)
                    }.fullScreenCover(isPresented: $isBookMarkTabbed) {
                        
//                        BookmarkListView(bookmarkListViewModel: BookmarkListViewModel, selectedIndex: Int)
//                            .frame(width: 970, height: 495)
                    }
                    
                    Button(action: {
                        isProfileTabbed = true
                        
                    }) {
                        Image(systemName: "person.fill")
                            .font(.title)
                            .foregroundColor(.primary01)
                            .frame(width: 30, height: 30)
                    }.fullScreenCover(isPresented: $isProfileTabbed) {
                        
                        ProfileView()
                            .frame(width: 970, height: 495)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // 스택 네비게이션 뷰 스타일 적용
    }
}


#Preview {
    NewsCardListView()
    
}
