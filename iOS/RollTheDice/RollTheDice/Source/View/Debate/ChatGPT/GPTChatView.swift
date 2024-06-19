//
//  GPTChatView.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import SwiftUI

struct GPTChatView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @StateObject var chatListViewModel = GPTChatListViewModel()
    @State var selectedChat: GPTChat? = .init(title: "토론제목입니다", messages: [.init(content: "ChatGPT와의 토론!", isUser: false)])
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            VStack {
                CustomNavigationBar(title: selectedChat?.title ?? "", isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), {pathModel.paths.popLast()})])
                MessageTitleView(chatListViewModel: chatListViewModel, selectedChat: $selectedChat)
            }
        }
    }
        
    
    private struct MessageTitleView: View {
        @ObservedObject var chatListViewModel: GPTChatListViewModel
        @Binding var selectedChat: GPTChat?
        @State var string: String = ""
        @State var index: Int? = 0
        
        fileprivate var body: some View {
            if chatListViewModel.chatList.isEmpty {
                // TODO: 채팅방 생성 뷰
            } else {
                HStack {
                    ScrollView {
                        ForEach(chatListViewModel.chatList.indices, id: \.self) { index in
                            Button {
                                selectedChat = chatListViewModel.chatList[index]
                            } label: {
                                TitleCellView(title: chatListViewModel.chatList[index].title)
                            }
                            
                        }
                    }
                    if selectedChat != nil {
                        VStack {
                            ScrollView {
                                ForEach(chatListViewModel.chatList[index ?? 0].messages ) { message in
                                    MessageCellView(message: message)
                                }
                            }
                            Divider()
                            
                            HStack {
                                TextField("Message...", text: $string, axis: .vertical)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.1))
                                    .foregroundStyle(.basicWhite)
                                    .cornerRadius(15)
                                Button {
                                    print("string : \(string)")
                                    
                                    chatListViewModel.sendNewMessage(index: index ?? 0, content: string)
                                    string = ""
                                } label: {
                                    Image(systemName: "paperplane")
                                }
                            }
                            .padding()

                            
                        }
                    } else {
                        // TODO: 채팅방 선택 유도 뷰
                        Spacer()
                    }
                    
                }
            }
        }
    }
    
    private struct TitleCellView: View {
        var title: String 
        fileprivate var body: some View {
            HStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .background(Color.basicBlack)
                    .foregroundStyle(.basicWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
    
    private struct MessageCellView:  View {
        var message: Message
        
        fileprivate var body: some View {
            Group {
                if message.isUser {
                    HStack {
                        Spacer()
                        Text(message.content)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                } else {
                    HStack {
                        Text(message.content)
                            .padding()
                            .background(Color.orange)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        Spacer()
                    }
                }
            }
        }
    }
}



#Preview {
    GPTChatView()
}
