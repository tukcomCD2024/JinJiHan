//
//  BookmarkView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct BookmarkListView: View {
    
    @EnvironmentObject var pathModel: PathModel
    var bookmarkListViewModel : BookmarksListViewModel
    var bookmarkPage: Int?
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
        .task {
            bookmarkListViewModel.getAllBookmarksData(page: 0, size: 10)
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    var bookmarkListView: some View {
        
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, spacing: 10) {
                    ForEach(bookmarkListViewModel.bookmarksList ?? []) { bookmark in
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
    BookmarkListView(bookmarkListViewModel: BookmarksListViewModel())
        .environmentObject(PathModel())
}
