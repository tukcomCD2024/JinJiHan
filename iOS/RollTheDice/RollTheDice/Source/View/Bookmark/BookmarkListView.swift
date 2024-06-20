//
//  BookmarkView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct BookmarkListView: View {
    @EnvironmentObject var pathModel: PathModel
    @StateObject var bookmarkListViewModel : BookmarkListViewModel
    @State var selectedIndex: Int = 0
    
    var columns: [GridItem] = [ GridItem(), GridItem()]
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            ZStack {
                bookmarkListView
//                BookmarkListContentView()
                    .padding(.leading, 20)
                VStack(spacing: 0) {
                    
                    CustomNavigationBar(
                        title: "북마크",
                        isDisplayLeadingBtn: true,
                        leadingItems: 
                            [
                                (Image(.chevronLeft), { pathModel.paths.popLast() }),
                            ]
                    )
                    
                    Spacer()
                    
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var bookmarkListView: some View {
        
        
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, spacing: 10) {
                    ForEach(bookmarkListViewModel.bookmarkList, id: \.self) { bookmark in
                        BookmarkView(bookmark: bookmark)
//                                .onTapGesture {
//                                    withAnimation {
//                                        selectedIndex = index
//                                        value.scrollTo(index)
//                                }
//                            }
                    }
                }
                .padding(.vertical, 90)
            }
        }
    }
    
//    private struct BookmarkListContentView: View {
//        @StateObject var bookmarkListViewModel: BookmarkListViewModel
//        var columns: [GridItem] = [ GridItem(), GridItem()]
//        
//        fileprivate var body: some View {
//            ScrollViewReader { value in
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHGrid(rows: columns, spacing: 10) {
//                        ForEach(bookmarkListViewModel.bookmarkList, id: \.self) { bookmark in
//                            BookmarkView(bookmark: bookmark)
////                                .onTapGesture {
////                                    withAnimation {
////                                        selectedIndex = index
////                                        value.scrollTo(index)
////                                }
////                            }
//                        }
//                    }
//                    .padding(.vertical, 90)
//                }
//            }
//        }
//    }
}

#Preview {
    BookmarkListView(bookmarkListViewModel: BookmarkListViewModel())
        .environmentObject(BookmarkListViewModel())
}
