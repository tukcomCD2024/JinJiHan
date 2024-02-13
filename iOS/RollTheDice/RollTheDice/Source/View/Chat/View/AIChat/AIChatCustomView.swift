//
//  AIChatCustomView.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import SwiftUI

struct AIChatCustomView: View {
    var body: some View {
        ChatBubbleView(text: "ChatGPT와의 채팅입니다\n원하는내용으로채팅시작해보세요.\n저는 준비가 되었습니다.\n진지한님 채팅을 시작해보세요.\nChatGPT와의 채팅입니다\n원하는내용으로채팅시작해보세요.\n저는 준비가 되었습니다.\n진지한님 채팅을 시작해보세요.\nChatGPT와의 채팅입니다\n원하는내용으로채팅시작해보세요.\n저는 준비가 되었습니다.\n진지한님 채팅을 시작해보세요.")
    }
}

struct ChatBubbleView: View {
    let text: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(text)
                    .padding()
                    .background(Color("primary01"))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding(.bottom,20)
            }
            
            Image("tim")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.leading,-120)
        }
    }
}


struct AIChatCustomView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatCustomView()
    }
}
