//
//  NewsCardListView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/4/24.
//

import Foundation
import SwiftUI

struct NewsCardListView: View {
    
    @State private  var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let card: [String] = ["Spoon","Spoon","Spoon","Spoon","Spoon","Spoon","Spoon","Spoon","Spoon","Spoon"]
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                ZStack {
                    Color.backgroundDark.ignoresSafeArea(.all)
                    
//                    Text("카드뉴스")
//                        .bold()
//                        .foregroundColor(.primary01)
                    
                    ForEach(0..<card.count, id: \.self) { index in
                        Image(card[index])
                            .frame(width: 300, height: 500)
                            .cornerRadius(25)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8 )
                            .offset(x : CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                        
                        
                        
                        
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation{
                                    currentIndex = min(card.count, -1, currentIndex, +1 )
                                }
                            }
                            
                        })
                    
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
                                currentIndex = min(card.count - 1, currentIndex + 1)
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
            
            
            
            
        }        .navigationViewStyle(StackNavigationViewStyle()) // 스택 네비게이션 뷰 스타일 적용

        
        
    }
    
}

#Preview {
    NewsCardListView()
    
}
