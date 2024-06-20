//
//  AuthenticationViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import Moya
import Combine
import CombineMoya


enum AuthenticationState {
    case unauthenticated    // Kakao & Apple 로그인 전
    case authenticated      // 로그인 후 회원가입 진행 중
    case completedSignUp    // 회원가입까지 성공
}

@Observable class AuthenticationViewModel: ObservableObject {
    // 로그인 상태에 따라 화면 분기처리
    var authenticationState: AuthenticationState = .unauthenticated
    var isLoading = false
    
    
    
    var authModel: AuthModel?
    var authCancellable: AnyCancellable?
    
    let provider = MoyaProvider<LoginService>(plugins: [MoyaLoggingPlugin()])
    
    func authModelToViewModel(_ list: AuthModel) {
        self.authModel = list
    }
}

extension AuthenticationViewModel {
    
    
    func loginWithKakao() {
        
        print("loginWithKakao")
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
//                            self.authenticationState = .authenticated
                            
                            // oauthToken 카카오에서 발급한 accessToken
//                            self.loginToBackend(with: oauthToken!.accessToken, socialType: "KAKAO")
                            let authRequest = AuthRequestModel(token: oauthToken!.accessToken, socialType: "KAKAO")
                            self.loginToBackend(authRequest: authRequest)
                        }
                    }
                }
            }
        } else {
            // Kakao 계정으로 로그인할 수 없는 경우 처리
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print("Kakao Login Error: \(error)")
                    self.authenticationState = .unauthenticated
                } else if let oauthToken = oauthToken {
                    print("Kakao Login Success: \(oauthToken)")
                    self.authenticationState = .authenticated
                    
                    let authRequest = AuthRequestModel(token: oauthToken.accessToken, socialType: "KAKAO")
                    self.loginToBackend(authRequest: authRequest)
                    
                }
            }
            
        }
    }
}

extension AuthenticationViewModel {
    
    func loginToBackend(authRequest: AuthRequestModel) {
        print("loginToBackend \(authRequest.token)")
        
        if let cancellable = authCancellable {
            cancellable.cancel()
        }
        
        authCancellable = provider.requestWithProgressPublisher(
            .login(request: authRequest)
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: AuthModel.self, decoder: JSONDecoder())
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("서버 토큰 발급 연결 성공")
                
                // TODO: 여기 지워야 함. 로그인 -> 회원가입 -> 메인 절차
                self.authenticationState = .completedSignUp
            case .failure(let error):
                Log.network("network error 서버 토큰 발급 연결 실패", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            self?.authModelToViewModel(response)
            print("서버 토큰 : \(response.accessToken)")
            
            TokenManager.shared.accessToken = response.accessToken
        })
    }
}

