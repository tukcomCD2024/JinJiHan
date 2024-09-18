//
//  RecentNewsService.swift
//  RollTheDice
//
//

import Foundation
import Moya

//MARK : 최근읽은 뉴스 관련 Service
enum RecentNewsService {
    case getViewedHistory
}

extension RecentNewsService: BaseTargetType {

    var path: String {
        switch self {
        case .getViewedHistory:
            return "/read-news/viewed-history"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getViewedHistory:
            return .get
        }
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        guard let token = TokenManager.shared.accessToken else {
            return nil
        }
        return ["Authorization": "Bearer \(token)"]
    }
}
