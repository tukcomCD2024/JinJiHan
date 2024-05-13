//
//  RecentNewsCardView.swift
//  RollTheDice
//
//  Created by Subeen on 4/30/24.
//

import SwiftUI

struct RecentNewsCardView: View {
    var body: some View {
        HStack {
            titleView
        }
//        .frame(width: 260, height: 244)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    var titleView: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image(.chevronLeft)
                Text("제목ahrhrhra제목 제목 미젝ㅁㄱㅈ 메좀ㄱㅈ게조깆거ㅣㅓ린러.ㄴ릴")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray07)
                    .font(.pretendardBold24)
                    .frame(width: 240, height: 96)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 30)
                    .background(.gray01)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .overlay {
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.gray05, lineWidth: 1.0)
                    }
                    .shadow(color: .basicBlack.opacity(0.1), radius: 2)
                Button {
                    
                } label: {
                    Text("토론 시작하기")
                        .foregroundStyle(.basicWhite)
                        .font(.pretendardRegular14)
                        .padding(.horizontal, 38)
                        .padding(.vertical, 10)
                        .background(.primary01)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 32)
        .background(.gray02)
    }
}

#Preview {
    RecentNewsCardView()
}
