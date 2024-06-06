//
//  GPTChatView.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

//import SwiftUI

//struct GPTChatView: View {
//    
//    @EnvironmentObject var pathModel: PathModel
//    @StateObject var chatListViewModel = GPTChatListViewModel()
//    @State var selectedChat: GPTChat? = .init(title: "hi", messages: [.init(content: "안녕하세요", isUser: false)])
//    
//    var body: some View {
//        ZStack {
//            Color.backgroundDark.ignoresSafeArea(.all)
//            VStack {
//                CustomNavigationBar(title: selectedChat?.title ?? "", isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), {pathModel.paths.popLast()})])
//                MessageTitleView(chatListViewModel: chatListViewModel, selectedChat: $selectedChat)
//            }
//        }
//    }
//        
//    
//    private struct MessageTitleView: View {
//        @ObservedObject var chatListViewModel: GPTChatListViewModel
//        @Binding var selectedChat: GPTChat?
//        @State var string: String = ""
//        @State var index: Int? = 0
//        
//        fileprivate var body: some View {
//            if chatListViewModel.chatList.isEmpty {
//                // TODO: 채팅방 생성 뷰
//            } else {
//                HStack {
//                    ScrollView {
//                        ForEach(chatListViewModel.chatList.indices, id: \.self) { index in
//                            Button {
//                                selectedChat = chatListViewModel.chatList[index]
//                            } label: {
//                                TitleCellView(title: chatListViewModel.chatList[index].title)
//                            }
//                            
//                        }
//                    }
//                    if selectedChat != nil {
//                        VStack {
//                            ScrollView {
//                                ForEach(chatListViewModel.chatList[index ?? 0].messages ) { message in
//                                    MessageCellView(message: message)
//                                }
//                            }
//                            Divider()
//                            
//                            HStack {
//                                TextField("Message...", text: $string, axis: .vertical)
//                                    .padding(5)
//                                    .background(Color.gray.opacity(0.1))
//                                    .foregroundStyle(.basicWhite)
//                                    .cornerRadius(15)
//                                Button {
//                                    print("string : \(string)")
//                                    
//                                    chatListViewModel.sendNewMessage(index: index ?? 0, content: string)
//                                    string = ""
//                                } label: {
//                                    Image(systemName: "paperplane")
//                                }
//                            }
//                            .padding()
//
//                            
//                        }
//                    } else {
//                        // TODO: 채팅방 선택 유도 뷰
//                        Spacer()
//                    }
//                    
//                }
//            }
//        }
//    }
//    
//    private struct TitleCellView: View {
//        var title: String 
//        fileprivate var body: some View {
//            HStack {
//                Text(title)
//                    .multilineTextAlignment(.leading)
//                    .padding(.horizontal)
//                    .background(Color.basicBlack)
//                    .foregroundStyle(.basicWhite)
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//            }
//        }
//    }
//    
//    private struct MessageCellView:  View {
//        var message: Message
//        
//        fileprivate var body: some View {
//            Group {
//                if message.isUser {
//                    HStack {
//                        Spacer()
//                        Text(message.content)
//                            .multilineTextAlignment(.leading)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundStyle(.white)
//                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                    }
//                    
//                } else {
//                    HStack {
//                        Text(message.content)
//                            .padding()
//                            .background(Color.orange)
//                            .foregroundStyle(.white)
//                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
//}

import SwiftUI


struct GPTChatView: View {
    @EnvironmentObject var pathModel: PathModel
    @StateObject var chatListViewModel = GPTChatListViewModel()
    @State var selectedChat: GPTChat?
    @State var string: String = ""
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            VStack {
                CustomNavigationBar(title: selectedChat?.title ?? "", isDisplayLeadingBtn: true, leadingItems: [(Image(systemName: "chevron.left"), { pathModel.paths.popLast() })])
                MessageTitleView(chatListViewModel: chatListViewModel, selectedChat: $selectedChat, string: $string)
            }
        }
        .onAppear {
            // 첫 번째 채팅방 자동 선택
            if chatListViewModel.chatList.isEmpty {
                selectedChat = nil
            } else {
                selectedChat = chatListViewModel.chatList.first
            }
        }
    }
    
    private struct MessageTitleView: View {
        @ObservedObject var chatListViewModel: GPTChatListViewModel
        @Binding var selectedChat: GPTChat?
        @Binding var string: String
        
        var body: some View {
            if chatListViewModel.chatList.isEmpty {
                Text("채팅방을 생성해주세요.")
            } else {
                HStack {
                    ScrollView {
                        ForEach(chatListViewModel.chatList.indices, id: \.self) { index in
                            Button {
                                selectedChat = chatListViewModel.chatList[index]
                                print("Selected chat: \(selectedChat?.title ?? "None")")
                            } label: {
                                TitleCellView(title: chatListViewModel.chatList[index].title)
                            }
                        }
                    }
                    if let selectedChat = selectedChat, let selectedIndex = chatListViewModel.chatList.firstIndex(of: selectedChat) {
                        VStack {
                            ScrollView {
                                ForEach(selectedChat.messages) { message in
                                    MessageCellView(message: message)
                                }
                            }
                            Divider()
                            HStack {
                                TextField("Message...", text: $string)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(15)
                                Button {
                                    chatListViewModel.sendNewMessage(index: selectedIndex, content: string)
                                    self.string = ""
                                    print("Button pressed. Index: \(selectedIndex), Content: \(string)")
                                } label: {
                                    Image(systemName: "paperplane")
                                }
                            }
                            .padding()
                        }
                    } else {
                        Text("채팅방을 선택해주세요.")
                    }
                }
            }
        }
    }
    
    private struct TitleCellView: View {
        var title: String
        var body: some View {
            HStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .background(Color.basicBlack)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
    
    private struct MessageCellView: View {
        var message: Message
        
        var body: some View {
            Group {
                if message.isUser {
                    HStack {
                        Spacer()
                        Text(message.content)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                } else {
                    HStack {
                        Text(message.content)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
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
