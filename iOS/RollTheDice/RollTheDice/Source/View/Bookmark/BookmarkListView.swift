//
//  BookmarkView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct BookmarkListView: View {
    @EnvironmentObject var bookmarkListViewModel : BookmarkListViewModel
    @State var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            BookmarkListContentView()
                .padding(.leading, 20)
        }
    }
    
    private struct BookmarkListContentView: View {
        @EnvironmentObject var bookmarkListViewModel: BookmarkListViewModel
        var columns: [GridItem] = [ GridItem(), GridItem() ]
        
        fileprivate var body: some View {
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
    }
}

#Preview {
    BookmarkListView()
        .environmentObject(BookmarkListViewModel())
}
