//
//  ChatView.swift
//  RollTheDice
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct ChatView: View {
    @State private var chatMessages: [String] = []
    @State private var userInput: String = ""
    @State private var selectedTitle: String?
    
    var body: some View {
        NavigationView {
            VStack {
                // 왼쪽에는 제목 목록 표시
                List {
                    ForEach(0..<10) { index in
                        Button(action: {
                            selectedTitle = "Title \(index)"
                        }) {
                            Text("Title \(index)")
                                .padding()
                        }
                    }
                }
                .listStyle(SidebarListStyle())
                .frame(minWidth: 100)
                
                // 오른쪽에는 채팅 내용 표시
                if let selectedTitle = selectedTitle {
                    ChatDetailView(title: selectedTitle, chatMessages: $chatMessages, userInput: $userInput, sendMessage: sendMessage)
                } else {
                    Text("Please select a title")
                        .font(.headline)
                        .padding()
                }
            }
            .navigationTitle("Chatting")
        }
    }
    
    func sendMessage() {
        guard !userInput.isEmpty else { return }
        chatMessages.append(userInput)
        userInput = ""
    }
}

struct ChatDetailView: View {
    let title: String
    @Binding var chatMessages: [String]
    @Binding var userInput: String
    let sendMessage: () -> Void
    
    var body: some View {
        VStack {
            Text("Chatting in \(title)")
                .font(.headline)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(chatMessages, id: \.self) { message in
                        Text(message)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            
            HStack {
                TextField("Type a message...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button(action: sendMessage) {
                    Text("Send")
                        .padding(.horizontal)
                }
                .disabled(userInput.isEmpty)
            }
            .padding(.bottom)
        }
    }
}


#Preview {
    ChatView()
}
