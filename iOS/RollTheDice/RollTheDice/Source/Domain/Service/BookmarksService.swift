//
//  BookmarksService.swift
//  RollTheDice
//
//  Created by Subeen on 6/14/24.
//

import Foundation
import Moya

enum BookmarksService {
    case bookmarksIsChecked(newsId: Int, accessToken: String)   ///뉴스 북마크 여부 조회
    case saveBookmarks(newsId: Int, accessToken: String)    ///북마크 저장
    case deleteBookmarks(newsId: Int, accessToken: String)  ///북마크 삭제
    case allBookmarks(page: Int, size: Int, accessToken: String)  ///북마크 전체 조회/
}

extension BookmarksService: BaseTargetType {
    
    var baseURL: URL {
        return URL(string: ScoopAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .bookmarksIsChecked(let newsId, _),
                .saveBookmarks(let newsId, _),
                .deleteBookmarks(let newsId, _)
            :
            return "\(ScoopAPIBookmarks.bookmarks)/\(newsId)"
            
        case .allBookmarks:
            return ScoopAPIBookmarks.bookmarks
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bookmarksIsChecked:
            return .get
        case .saveBookmarks:
            return .post
        case .deleteBookmarks:
            return .delete
        case .allBookmarks:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bookmarksIsChecked(let newsId, _),
                .saveBookmarks(let newsId, _),
                .deleteBookmarks(let newsId, _):
            let parameters : [String : Any] = [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .allBookmarks(let page, let size, _):
            let parameters : [String : Any] = [
                "page" : page,
                "size" : size,
            ]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let accessToken: String
        switch self {
        case .bookmarksIsChecked(_, let accessToken),
                .saveBookmarks(_, let accessToken),
                .deleteBookmarks(_, let accessToken),
                .allBookmarks(_, _, let accessToken):
            return [
                "Authorization": "Bearer \(accessToken)",
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}
