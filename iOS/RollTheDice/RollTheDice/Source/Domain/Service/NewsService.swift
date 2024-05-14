//
//  NewsService.swift
//  RollTheDice
//
//  Created by Subeen on 3/21/24.
//

import Foundation
import Moya

enum NewsService {
    case news(page: Int, size: Int, sort: String, token: String)
}

extension NewsService: BaseTargetType {
    var baseURL: URL {
        return URL(string: ScoopAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .news:
            return ScoopAPINews.newsFetch
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .news:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .news(let page, let size, let sort, _):
            let parameters : [String : Any] = [
                "page" : page,
                "size" : size,
                "sort" : sort
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let token: String
        switch self {
        case .news(_, _, _, let tokenValue):
            token = tokenValue
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
    }
}
