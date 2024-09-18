//
//  ChatView.swift
//  RollTheDice
//
//  Created by Subeen on 9/19/24.
//

import SwiftUI

struct ChatView: View {
    
    var topic: String
    var roomId: Int
    @StateObject var chatViewModel =  ChatViewModel()
    @State var sendContent: String = ""
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(title: topic, isDisplayLeadingBtn: true, leadingItems: [(Image(.chevronLeft), { pathModel.paths.popLast() })])
                messageView
                Divider()
                HStack {
                    TextField("Message", text: self.$sendContent, axis: .vertical)
                    Button {
                        chatViewModel.sendUserMessage(roomId: roomId, content: sendContent)
                        sendContent = ""
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    
                    Button {
                        chatViewModel.deleteChatRoom(roomId: roomId)
                        pathModel.paths.popLast()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .onAppear {
            chatViewModel.newsId = self.roomId
            chatViewModel.sendInitialMessage(roomId: roomId, content: topic)
            chatViewModel.getDebatesMsg(roomId: roomId)
        }
    }
    
    
    @ViewBuilder
    var messageView: some View {
        ScrollView {
            VStack {
                ForEach(chatViewModel.chatList?.data ?? []) { msg in
                    messageCellView(msg: msg)
                }
            }
        }
    }
    
    @ViewBuilder
    func messageCellView(msg: Message) -> some View {
        Group {
            if msg.senderType == .human {
                HStack {
                    Spacer()
                    Text(msg.message ?? "")
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
            } else {
                HStack {
                    Text(msg.message ?? "")
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

#Preview {
    ChatView(topic: "", roomId: 400, sendContent: "")
        .environmentObject(PathModel())
}
