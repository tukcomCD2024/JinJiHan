//
//  AuthenticatedView.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

struct AuthenticatedView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var pathModel: PathModel
   
    var totalDuration = 10.0
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray01)
                .overlay {
                    VStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.gray07)
                        
                        Spacer()
                            .frame(height: 66)
                        
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.gray07)
                                .frame(height: 87)
                            
                            Text("Scoop!")
                                .frame(height: heightForFontSize(size: 150))
                                .font(.pretendardBold150)
                                .foregroundStyle(.basicBlack)
                        }
                        
                        Spacer()
                        keyFrameView
                        
                        Spacer()
                        
                        signInButtonView
                        
                        Spacer()
                            .frame(height: 30)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.gray07)
                        
                        
                        
                       
                    }
                    .padding(.vertical, 50)
                    .padding(.horizontal, 60)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: 880, maxHeight: 600)
        
        
        
    }
    
    // TODO : 애니메이션 반복시 자연스럽게 연결 하기
    var keyFrameView: some View {
//        ScrollView(.horizontal) {
            HStack(spacing: 70) {
                Image(.scoopGray01)
                    .scoopImageModifier()
                Image(.scoopOrange04)
                    .scoopImageModifier()
                Image(.scoopGray02)
                    .scoopImageModifier()
                Image(.scoopOrange03)
                    .scoopImageModifier()
                Image(.scoopGray03)
                    .scoopImageModifier()
                Image(.scoopOrange02)
                    .scoopImageModifier()
                Image(.scoopGray04)
                    .scoopImageModifier()
                Image(.scoopOrange01)
                    .scoopImageModifier()
                Image(.scoopGray01)
                    .scoopImageModifier()
                Image(.scoopOrange04)
                    .scoopImageModifier()
                Image(.scoopGray02)
                    .scoopImageModifier()
            }
            .keyframeAnimator(initialValue: AnimationProperty(), repeating: true) { content, value in
                content
                    .offset(x: value.xTranslation)
            } keyframes: { _ in
                KeyframeTrack(\.xTranslation) {
                    LinearKeyframe(-200, duration: totalDuration)
                    LinearKeyframe(200, duration: totalDuration)

                }
            }
    }
    
    var signInButtonView: some View {
        HStack {
            Button {
                authViewModel.authenticationState = .authenticated
            } label: {
                Image(.appleSignInBtn01)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
            }
            
            Button {
                authViewModel.loginWithKakao()
            } label: {
                Image(.kakaoSignInBtn01)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
            }

        }
        
    }
}

struct AnimationProperty {
    var xTranslation = 0.0
}

#Preview {
    AuthenticatedView()
}
