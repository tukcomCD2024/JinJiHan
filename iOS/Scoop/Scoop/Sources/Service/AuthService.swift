//
//  AuthService.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
//

import Foundation
import Combine
import CombineMoya
import Moya
import KakaoSDKAuth
import KakaoSDKUser

protocol AuthServiceType {
    func signUp()
    func getKakaoCode() async throws -> String
    func login(authRequest: AuthRequestModel) async
}

class AuthService: AuthServiceType {
    
    private let jsonDecoder = JSONDecoder()
    
    let provider = MoyaProvider<AuthTarget>()
    
    let accessToken: String? = TokenManager.shared.accessToken
    
    
    func signUp() {
        
    }
    
    func getKakaoCode() async throws -> String {
        if UserApi.isKakaoTalkLoginAvailable() {
            return try await withCheckedThrowingContinuation { continuation in
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let oauthToken = oauthToken {
                        let code = oauthToken.accessToken
                        print("⭐️ kakao code : \(code)")
                        continuation.resume(returning: code)
                    }
                }
            }
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let oauthToken = oauthToken {
                        let code = oauthToken.accessToken
                        print("⭐️ kakao code : \(code)")
                        continuation.resume(returning: code)
                    }
                }
            }
        }
    }
     
    func login(authRequest: AuthRequestModel) async {
        
    }
}
