//
//  SignUpFinishView.swift
//  RollTheDice
//
//  Created by Subeen on 3/10/24.
//

import SwiftUI

struct SignUpFinishView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    var body: some View {
        
        VStack(spacing: 40) {
            Text("회원가입 완료!")
                .font(.pretendardBold40)
            Button {
                authViewModel.authenticationState = .completedSignUp
            } label: {
                Text("스쿱 보러 가기 🥄")
                    .foregroundStyle(.basicWhite)
                    .font(.pretendardBold24)
                    .padding(20)
                    .background(.primary01)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
}

#Preview {
    SignUpFinishView()
        .environmentObject(AuthenticationViewModel())
}
