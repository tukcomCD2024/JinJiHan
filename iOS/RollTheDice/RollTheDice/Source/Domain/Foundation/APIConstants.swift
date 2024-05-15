//
//  APIConstants.swift
//  RollTheDice
//
//  Created by Subeen on 3/21/24.
//

import Foundation

struct APIConstants{
    static let contentType = "Content-Type"
    static let host = "Host"
    
}

extension APIConstants {
    static var baseHeader: Dictionary<String, String> {
        [
            contentType : APIHeaderManager.shared.contentType,
            host : APIHeaderManager.shared.scoopHost,
        ]
    }
}

