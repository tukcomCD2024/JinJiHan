////
////  ReadNewsTarget.swift
////  Scoop
////
////  Created by Subeen on 9/5/24.
////
//
//import Foundation
//import Moya
//
//enum ReadNewsTarget {
//    case readNewsHistory(accessToken: String)    // 최근 읽은 뉴스 조회
//}
//
//extension ReadNewsTarget: BaseTargetType {
//    var path: String {
//        switch self {
//        case .readNewsHistory:
//            return ReadNewsAPI.readNewsHistory.apiDesc
//        }
//    }
//    
//    var method: Moya.Method {
//        switch self {
//        case .readNewsHistory:
//            return .get
//        }
//    }
//    
//    var task: Moya.Task {
//        switch self {
//        case .readNewsHistory:
//            
//        }
//    }
//    
//    var headers: [String : String]? {
//        let token: String
//        switch self {
//        case .getAllNews(_, _, let accessToken),
//        .getDetailNews(_, let accessToken):
//        
//            token = accessToken
//            return [
//                "Authorization": "Bearer \(token)",
//                "X-Content-Type_Options" : "nosniff"
//            ]
//        }
//    }
//}
