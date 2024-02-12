//
//  TestView.swift
//  RollTheDice
//
//  Created by 신예진 on 2/9/24.
//

import SwiftUI

//왼쪽 TITLE 눌렀을 때 들어가는 View
struct ChatTitleView: View {
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
                        .foregroundColor(selectedIndex == index ? .white : .primary)
                        .padding()
                }
                .background(selectedIndex == index ? Color.primary01 : Color.black)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }
}

struct ChatTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTitleView()
    }
}
