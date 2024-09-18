//
//  NewsTarget.swift
//  Scoop
//
//  Created by Subeen on 9/5/24.
//

import Foundation
import Moya

enum NewsTarget {
    case getAllNews(page: Int, size: Int, accessToken: String)      // 요약 뉴스 전체 조회
    case getDetailNews(newsId: Int, accessToken: String)            // 요약 뉴스 상세 조회
}

extension NewsTarget: BaseTargetType {
    var path: String {
        switch self {
        case .getAllNews:
            return NewsAPI.getAllNews.apiDesc
        case .getDetailNews(let newsId, _):
            return NewsAPI.getDetailNews(newsId).apiDesc
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllNews(let page, let size, let accessToken):
            return .get
        case .getDetailNews(let newsId, let accessToken):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllNews(let page, let size, _):
            let parameters : [String : Any] = [
                "page" : page,
                "size" : size
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .getDetailNews(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let token: String
        switch self {
        case .getAllNews(_, _, let accessToken),
        .getDetailNews(_, let accessToken):
        
            token = accessToken
            return [
                "Authorization": "Bearer \(token)",
                "X-Content-Type_Options" : "nosniff"
            ]
        }
    }
}
