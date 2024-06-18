//
//  AuthenticationViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser


enum AuthenticationState {
    case unauthenticated    // Kakao & Apple 로그인 전
    case authenticated      // 로그인 후 회원가입 진행 중
    case completedSignUp    // 회원가입까지 성공
}

@Observable class AuthenticationViewModel: ObservableObject {
    // 로그인 상태에 따라 화면 분기처리
    var authenticationState: AuthenticationState = .unauthenticated
    var isLoading = false
}

extension AuthenticationViewModel {
    func loginWithKakao() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                    self.authenticationState = .unauthenticated
                } else {
                    // 로그인 성공 시 사용자 정보 가져오기
                    UserApi.shared.me { (user, error) in
                        if let error = error {
                            print("Kakao user info error: \(error)")
                            self.authenticationState = .unauthenticated
                        } else {
                            // 사용자 정보 처리
                            self.authenticationState = .authenticated
                        }
                    }
                }
            }
        } else {
            // Kakao 계정으로 로그인할 수 없는 경우 처리
            self.authenticationState = .unauthenticated
        }
    }
}

extension AuthenticationViewModel {
    func loginToBackend(with token: String) {
        AuthProvider.provider.request(.login(token: token)) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try response.mapJSON()
                    print("Login response: \(json)")
                    self.authenticationState = .completedSignUp
                } catch {
                    print("Login error: \(error)")
                    self.authenticationState = .unauthenticated
                }
            case .failure(let error):
                print("Login error: \(error)")
                self.authenticationState = .unauthenticated
            }
        }
    }
}

