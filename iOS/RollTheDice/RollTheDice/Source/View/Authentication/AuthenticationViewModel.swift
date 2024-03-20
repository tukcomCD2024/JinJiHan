//
//  AuthenticationViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    // 로그인 상태에 따라 화면 분기처리
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLoading = false
}
