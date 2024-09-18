//
//  BookmarkTarget.swift
//  Scoop
//
//  Created by Subeen on 9/5/24.
//

import Foundation
import Moya

enum BookmarkTarget {
    case getIsBookmarked(newsId: Int, accessToken: String)    // 뉴스 북마크 여부 조회
    case saveBookmark(newsId: Int, accessToken: String)       // 북마크 저장
    case deleteBookmark(newsId: Int, accessToken: String)     // 북마크 삭제
    case getAllBookmark(accessToken: String)             // 북마크 전체 조회
}

extension BookmarkTarget: BaseTargetType {
    
    var path: String {
        switch self {
        case .getIsBookmarked(let newsId, _):
            return BookmarkAPI.getIsBookmarked(newsId).apiDesc
        case .saveBookmark(let newsId, _):
            return BookmarkAPI.saveBookmark(newsId).apiDesc
        case .deleteBookmark(let newsId, _):
            return BookmarkAPI.deleteBookmark(newsId).apiDesc
        case .getAllBookmark(_):
            return BookmarkAPI.getAllBookmark.apiDesc
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getIsBookmarked:
            return .get
            
        case .saveBookmark:
            return .post
        
        case .deleteBookmark:
            return .delete
        
        case .getAllBookmark:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getIsBookmarked,
                .saveBookmark,
                .deleteBookmark,
                .getAllBookmark:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {

        let token: String
            
        switch self {
        case .getIsBookmarked(_, let accessToken),
                .saveBookmark(_, let accessToken),
                .deleteBookmark(_, let accessToken),
                .getAllBookmark(let accessToken):
            token = accessToken
            return [
                "Authorization": "Bearer \(token)",
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}
