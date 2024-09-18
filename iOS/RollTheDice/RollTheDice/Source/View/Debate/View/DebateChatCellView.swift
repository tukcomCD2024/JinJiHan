//
//  DebateChatCellView.swift
//  RollTheDice
//
//  Created by Subeen on 9/19/24.
//

import Foundation
import SwiftUI

struct DebateChatCellView: View {
    var debate: DebateChatDatum?
    let emojis = ["🏛️", "🔥", "📌", "⭐️", "🧬", "👩🏼‍💻", "🎨", "🎬", "💌", "🔗", "👀"]

//        @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        let randomEmoji = emojis.randomElement() ?? "🏛️" // 이모지가 선택되지 않으면 기본값을 설정합니다.
        
        HStack {
            HStack(alignment: .center, spacing: 16) {
                Text(randomEmoji)
                    .padding(.leading, 26)
                    .font(.pretendardBold32)
                Text(debate?.topic ?? "")
                    .foregroundStyle(.gray07)
                    .font(.pretendardBold24)
                    .padding(.vertical, 24)
                    
                Spacer()
                Button {
//                        pathModel.paths.append(.chatView(isAiMode: true))
                } label: {
                    
                }
            }
            .background(.gray01)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 16)
            
            Button {
//                    pathModel.paths.append(.debateSummaryView)
            } label: {

            }
            .frame(width: 80, height: 80)
            .background(.gray01)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
