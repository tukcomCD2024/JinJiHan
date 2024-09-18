//
//  AuthenticationViewModel.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
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
class AuthenticationViewModel: ObservableObject {
    
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var authenticationState: AuthenticationState = .unauthenticated
}

extension AuthenticationViewModel {
    
}

