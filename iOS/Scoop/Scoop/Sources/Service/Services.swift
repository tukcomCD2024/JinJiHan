//
//  Services.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthServiceType { get set }
    var newsSerivce: NewsSerivceType { get set }
}

class Services: ServiceType {
    
    var authService: AuthServiceType
    var newsSerivce: NewsSerivceType
    
    init() {
        self.newsSerivce = NewsSerivce()
        self.authService = AuthService()
    }
}

class StubServices: ServiceType {
    var authService: AuthServiceType = AuthService()
    var newsSerivce: NewsSerivceType = NewsSerivce()
}
