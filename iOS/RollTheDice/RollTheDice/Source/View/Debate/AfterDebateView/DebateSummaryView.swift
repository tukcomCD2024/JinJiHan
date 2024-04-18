//
//  DebateSummaryView.swift
//  RollTheDice
//
//  Created by 신예진 on 4/18/24.
//

import Foundation
import SwiftUI

struct DebateSummaryView: View {
    
    @State var summaryText = "이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자?이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자?이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자? 이번 토론 내용 요약 100자?"
        
    
    var body: some View {
        ZStack{
            
            
            HStack{
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 461, height: 282)
                  .background(.gray03)
                  .cornerRadius(60)
                
                Image("Vector")
                  .frame(width: 110, height: 161)
                  .padding(.top, -110)
                  .padding(.leading, -50)
                
            }
            
            Text(summaryText)
              .font(Font.custom("Pretendard", size: 18))
              .foregroundColor(.basicBlack)
              .frame(width: 384, alignment: .bottomLeading)
              .padding(.trailing, 38)
            
             

            
        }
    }
}

#Preview {
    DebateSummaryView()
        
}
