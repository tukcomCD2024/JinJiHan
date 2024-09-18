//
//  AuthenticatedView.swift
//  Scoop
//
//  Created by Subeen on 9/18/24.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

struct AuthenticatedView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var authViewModel: AuthenticationViewModel
//    @EnvironmentObject var pathModel: PathModel
   
    var totalDuration = 10.0
    
    var body: some View {
        switch authViewModel.authenticationState {
        case .unauthenticated:
            SignInIntroView()
        case .authenticated:
            MainView()
        case .completedSignUp:
            Text("회원가입 완료")
        }
        
    }
    
    // TODO : 애니메이션 반복시 자연스럽게 연결 하기
//    var keyFrameView: some View {
//        ScrollView(.horizontal) {
//            HStack(spacing: 70) {
//                Image(.scoopGray01)
//                    .scoopImageModifier()
//                Image(.scoopOrange04)
//                    .scoopImageModifier()
//                Image(.scoopGray02)
//                    .scoopImageModifier()
//                Image(.scoopOrange03)
//                    .scoopImageModifier()
//                Image(.scoopGray03)
//                    .scoopImageModifier()
//                Image(.scoopOrange02)
//                    .scoopImageModifier()
//                Image(.scoopGray04)
//                    .scoopImageModifier()
//                Image(.scoopOrange01)
//                    .scoopImageModifier()
//                Image(.scoopGray01)
//                    .scoopImageModifier()
//                Image(.scoopOrange04)
//                    .scoopImageModifier()
//                Image(.scoopGray02)
//                    .scoopImageModifier()
//            }
//            .keyframeAnimator(initialValue: AnimationProperty(), repeating: true) { content, value in
//                content
//                    .offset(x: value.xTranslation)
//            } keyframes: { _ in
//                KeyframeTrack(\.xTranslation) {
//                    LinearKeyframe(-200, duration: totalDuration)
//                    LinearKeyframe(200, duration: totalDuration)
//
//                }
//            }
//    }
    
    var signInButtonView: some View {
        HStack {
            Button {
//                authViewModel.authenticationState = .authenticated
            } label: {
//                Image(.appleSignInBtn01)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 50)
            }
            
//            Button {
//                authViewModel.loginWithKakao()
//            } label: {
//                Image(.kakaoSignInBtn01)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 50)
//            }

        }
        
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static let container: DIContainer = .stub
    
    static var previews: some View {
        AuthenticatedView(authViewModel: .init(container: container))
            .environmentObject(container)
    }
}
