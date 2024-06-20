//
//  GPTChatView.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import SwiftUI

struct GPTChatView: View {
    
    @EnvironmentObject var pathModel: PathModel
//    @State var selectedChat: GPTChat? = .init(title: "토론제목입니다", messages: [.init(content: "ChatGPT와의 토론!", isUser: false)])
    @State var selectedChat: GPTChat?
    @StateObject var chatListViewModel = GPTChatListViewModel(topic: "토론")
    @StateObject var createDebateRoomViewModel = CreateDebateRoomViewModel()
    @StateObject private var viewModel = EndDebateViewModel()
    var roomId: Int

    init(topic: String, roomId: Int) {
        self.roomId = roomId
        _chatListViewModel = StateObject(wrappedValue: GPTChatListViewModel(topic: topic))
        _selectedChat = State(initialValue: GPTChat(title: topic, messages: [.init(content: "\(createDebateRoomViewModel.topic) ChatGPT와의 토론!", isUser: false)]))
    }
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            VStack {
                CustomNavigationBar(title: selectedChat?.title ?? "", isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), {pathModel.paths.popLast()})])
                
                MessageTitleView(chatListViewModel: chatListViewModel, selectedChat: $selectedChat, roomId: roomId)
                
            }
        }
    }
        
    
    private struct MessageTitleView: View {
        @ObservedObject var chatListViewModel: GPTChatListViewModel
        @Binding var selectedChat: GPTChat?
        @State var string: String = ""
        @State var index: Int? = 0
        @StateObject private var viewModel = EndDebateViewModel()
        var roomId: Int
        @EnvironmentObject var pathModel: PathModel

        
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
                            
                            //MARK : 토론 종료 버튼
                            Button(action: {
                                print("토론종료버튼 눌림!")
                                viewModel.endDebate(roomId: "\(roomId)") { success in
                                    if success {
                                        print("토론이 종료되었습니다.")
//                                        pathModel.paths.append(.debateSummaryView)
                                        pathModel.paths.popLast()
<<<<<<< HEAD

=======
>>>>>>> DeviOS
                                    } else {
                                        print("토론 종료에 실패했습니다.")
                                    }
                                }
                                
                                
                            }) {
                                Text("토론종료")
                                    .font(.title3.weight(.semibold))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.primary01)
                                    .cornerRadius(15)
                                    .shadow(radius: 4, x: 0, y: 4)
                            }
                            .frame(width: 100, height: 30)
                            .padding(.bottom, 20)
                            
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
                                        .foregroundColor(.primary01)

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



//#Preview {
//    GPTChatView()
//}

//struct GPTChatView: View {
<<<<<<< HEAD
//    
=======
//
>>>>>>> DeviOS
//    @EnvironmentObject var pathModel: PathModel
//    @State var selectedChat: GPTChat?
//    @StateObject var chatListViewModel: GPTChatListViewModel
//    @StateObject var createDebateRoomViewModel = CreateDebateRoomViewModel()
//
//    init(topic: String) {
//        _chatListViewModel = StateObject(wrappedValue: GPTChatListViewModel(topic: topic))
//        _selectedChat = State(initialValue: GPTChat(title: topic, messages: [.init(content: "\(topic)ChatGPT와의 토론!", isUser: false)]))
//    }
<<<<<<< HEAD
//    
=======
//
>>>>>>> DeviOS
//    var body: some View {
//        ZStack {
//            Color.backgroundDark.ignoresSafeArea(.all)
//            VStack {
//                CustomNavigationBar(title: selectedChat?.title ?? "", isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), {pathModel.paths.popLast()})])
//                MessageTitleView(chatListViewModel: chatListViewModel, selectedChat: $selectedChat)
//            }
//        }
//    }
<<<<<<< HEAD
//        
=======
//
>>>>>>> DeviOS
//    private struct MessageTitleView: View {
//        @ObservedObject var chatListViewModel: GPTChatListViewModel
//        @Binding var selectedChat: GPTChat?
//        @State var string: String = ""
//        @State var index: Int? = 0
<<<<<<< HEAD
//        
=======
//
>>>>>>> DeviOS
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
//                        }
//                    }
//                    if selectedChat != nil {
//                        VStack {
//                            ScrollView {
//                                ForEach(selectedChat?.messages ?? []) { message in
//                                    MessageCellView(message: message)
//                                }
//                            }
//                            Divider()
<<<<<<< HEAD
//                            
=======
//
>>>>>>> DeviOS
//                            HStack {
//                                TextField("Message...", text: $string, axis: .vertical)
//                                    .padding(5)
//                                    .background(Color.gray.opacity(0.1))
//                                    .foregroundStyle(.basicWhite)
//                                    .cornerRadius(15)
//                                Button {
//                                    if let index = chatListViewModel.chatList.firstIndex(where: { $0.id == selectedChat?.id }) {
//                                        chatListViewModel.sendNewMessage(index: index, content: string)
//                                        string = ""
//                                    print("왜 채팅하기 버튼 안 눌려?")
//                                    }
//                                } label: {
//                                    Image(systemName: "paperplane")
//                                }
//                            }
//                            .padding()
//                        }
//                    } else {
//                        // TODO: 채팅방 선택 유도 뷰
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
<<<<<<< HEAD
//    
=======
//
>>>>>>> DeviOS
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
<<<<<<< HEAD
//    
//    private struct MessageCellView:  View {
//        var message: Message
//        
=======
//
//    private struct MessageCellView:  View {
//        var message: Message
//
>>>>>>> DeviOS
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
<<<<<<< HEAD
=======

>>>>>>> DeviOS
