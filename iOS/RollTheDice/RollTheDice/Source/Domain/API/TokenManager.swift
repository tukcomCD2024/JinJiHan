//
//  TokenManager.swift
//  RollTheDice
//
//  Created by 신예진 on 6/14/24.
//

import Foundation
import SwiftUI

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
