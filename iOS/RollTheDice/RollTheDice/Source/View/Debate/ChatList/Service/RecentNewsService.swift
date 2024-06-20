//
//  RecentNewsService.swift
//  RollTheDice
//
//  Created by 신예진 on 6/19/24.
//

import Foundation
import Moya

//MARK : 최근읽은 뉴스 관련 Service
enum RecentNewsService {
    case getViewedHistory
}

extension RecentNewsService: TargetType {
    var baseURL: URL {
        return URL(string: "http://roll-the-dice.store:8080")!
    }

    var path: String {
        switch self {
        case .getViewedHistory:
            return "/news/viewed-history"
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

    var sampleData: Data {
        return Data()
    }
}
