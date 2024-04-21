//
//  DebateSummaryView.swift
//  RollTheDice
//
//  Created by Subeen on 4/22/24.
//

import SwiftUI

struct DebateSummaryView: View {
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            
            VStack {
                CustomNavigationBar(title: "토론요약", isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), {})])
                
                sumView

            }
        }
    }
    
    var sumView: some View {
        HStack(spacing: 0) {
            Rectangle()
                .foregroundStyle(
                    LinearGradient(colors: [.gray02, .gray02, .gray04], startPoint: .leading, endPoint: .trailing)
                
                )
                .frame(width: 88)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
            
            ZStack {
                
                UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                    .offset(x: 30, y: 20)
                    .foregroundStyle(.gray05)
                    .padding(.bottom, 20)
                Rectangle()
                    .foregroundStyle(
                        LinearGradient(colors: [.gray03, .gray02], startPoint: .leading, endPoint: .trailing)
                    
                    )
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
                    .overlay {
                        UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                            .stroke(.gray07, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    }
                    
                
            }
        }
        .padding(.top, 60)
        .padding(.horizontal, 110)
    }
}

#Preview {
    DebateSummaryView()
}
