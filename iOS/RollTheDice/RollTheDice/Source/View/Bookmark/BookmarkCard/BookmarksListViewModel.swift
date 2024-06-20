//
//  BookmarkListViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 2/12/24.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

@Observable class BookmarksListViewModel{
    var bookmarksList: [Bookmarks]?
    var bookmarksCancellable: AnyCancellable?
    
    let provider = MoyaProvider<BookmarksService>(plugins: [MoyaLoggingPlugin()])
    
    func bookmarksToViewModel(_ list: [Bookmarks]) {
        self.bookmarksList = list
    }
}

extension BookmarksListViewModel {
    
    /// 북마크 전체 조회
    public func getAllBookmarksData(page: Int, size: Int) {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        if let cancellable = bookmarksCancellable {
            cancellable.cancel()
        }
        
        bookmarksCancellable = provider.requestWithProgressPublisher(
                .allBookmarks(
                    page: page,
                    size: size,
                    accessToken: accessToken
                )
        
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: [Bookmarks].self, decoder: JSONDecoder())
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("all bookmarks 조회 성공")
            case .failure(let error):
                Log.network("network error", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            self?.bookmarksToViewModel(response)
            print(response)
        })
    }
    
    /// 뉴스 북마크 여부 조회
    public func isBookmark(newsId: Int) -> Bool {
        
        var isBookmarked: Bool = false
        
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return isBookmarked
        }
        
        if let cancellable = bookmarksCancellable {
            cancellable.cancel()
        }
        
        bookmarksCancellable = provider.requestWithProgressPublisher(
            .saveBookmarks(
                newsId: newsId,
                accessToken: accessToken
            )
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: Bookmarks.self, decoder: JSONDecoder())
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("bookmark 여부 확인 성공")
            case .failure(let error):
                Log.network("network error bookmark 여부 확인 실패", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            print(response)
            
            if response.isBookmarked ?? false {
                isBookmarked = true
            } else {
                isBookmarked = false
            }
        })
        
        return isBookmarked
    }
    
    /// 북마크 저장
    
    
    /// 북마크 삭제
    
    
}
