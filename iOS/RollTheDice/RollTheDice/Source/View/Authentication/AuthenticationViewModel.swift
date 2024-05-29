//
//  AuthenticationViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import Foundation

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
