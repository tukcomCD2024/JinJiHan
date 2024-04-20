//
//  APIConstants.swift
//  RollTheDice
//
//  Created by Subeen on 3/21/24.
//

import Foundation

struct APIConstants{
//    static var viewModel: BoardViewModel = BoardViewModel()
    static let contentType = "Content-Type"
    static let host = "Host"
//    static let Cookie = "Cookie"
    
}

extension APIConstants {
    static var baseHeader: Dictionary<String, String> {
        [
            contentType : APIHeaderManger.shared.contentType,
            host : APIHeaderManger.shared.rtdHost,
//            Cookie : "accessToken=\(viewModel.authCodeToken)"
        ]
    }
}

