//
//  SignUpView.swift
//  RollTheDice
//
//  Created by Subeen on 3/10/24.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            VStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Image(.appleLoginBtn)
                }
                
                Button {
                    
                } label: {
                    Image(.kakaoLoginBtn)
                }
                Spacer()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

private struct LoginView: View {
    fileprivate var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    SignUpView()
}
