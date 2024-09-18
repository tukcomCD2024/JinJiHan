//
//  BookmarkAPI.swift
//  RolltheDice
//
//  Created by Subeen on 9/5/24.
//

import Foundation

public enum BookmarkAPI {
    case getIsBookmarked(Int)    // 뉴스 북마크 여부 조회
    case saveBookmark(Int)       // 북마크 저장
    case deleteBookmark(Int)     // 북마크 삭제
    case getAllBookmark             // 북마크 전체 조회
    
    public var apiDesc: String {
        switch self {
        case .getIsBookmarked(let newsId):
            "/bookmarks/\(newsId)"
        case .saveBookmark(let newsId):
            "/bookmarks/\(newsId)"
        case .deleteBookmark(let newsId):
            "/bookmarks/\(newsId)"
        case .getAllBookmark:
            "/bookmarks"
        }
    }
}
