//
//  NewsService.swift
//  RollTheDice
//
//  Created by Subeen on 3/21/24.
//

import Foundation
import Moya

enum NewsService {
    case news(page: Int, size: Int, accessToken: String)    /// 요약 뉴스 전체 조회
    case newsDetail(newsId: Int, accessToken: String)             /// 요약 뉴스 상세 조회
}

extension NewsService: BaseTargetType {
    var baseURL: URL {
        return URL(string: ScoopAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .news:
            return ScoopAPINews.newsFetch
            
        case .newsDetail(let newsId, _):
            return "\(ScoopAPINews.newsFetch)/\(newsId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .news:
            return .get
        case .newsDetail:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .news(let page, let size, _):
            let parameters : [String : Any] = [
                "page" : page,
                "size" : size,
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        case .newsDetail(let newsId, _):
            let parameters : [String : Any] = [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        
        
    }
    
    var headers: [String : String]? {
        let accessToken: String
        switch self {
        case .news(_, _, let accessTokenValue):
            accessToken = accessTokenValue
            return [
//                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)",
                "X-Content-Type_Options" : "nosniff"
            ]
        
            
        case .newsDetail(_, let accessTokenValue):
            accessToken = accessTokenValue
            return [
                "Authorization": "Bearer \(accessToken)",
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}
