//
//  AIChatTitleView.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import SwiftUI

//왼쪽 TITLE 눌렀을 때 들어가는 View
struct AIChatTitleView: View {
    @State private var selectedTitle: String = ""
    @State private var selectedIndex: Int?
    
    var body: some View {
        VStack {
            ForEach(0..<20) { index in
                Button(action: {
                    selectedTitle = "여기에채팅제목이뜹니다. \(index)"
                    selectedIndex = index
                }) {
                    Text("여기에채팅제목이뜹니다. \(index)")
                        .foregroundColor(.basicWhite)
                        .padding()
                }
                .background(selectedIndex == index ? Color.primary01 : Color.black)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }
}

struct AIChatTitleView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatTitleView()
    }
}
