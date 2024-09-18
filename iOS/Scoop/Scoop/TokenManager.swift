//
//  TokenManager.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    private init() { }
    
    private let accessTokenKey = "accessToken"
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {

            UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
        }
    }
}
