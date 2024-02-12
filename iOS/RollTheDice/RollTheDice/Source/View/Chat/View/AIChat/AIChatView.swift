//
//  AIChatView.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import SwiftUI

struct AIChatView: View {
    @State private var text: String = ""
    @State private var messages: [String] = []
    
    var body: some View {
        ScrollView{
            HStack {
                AIChatTitleView()
                
                Spacer()
                
                VStack {
                    AIChatCustomView()
                        .padding(.leading,-400)
                    
                    MyChatCustomView()
                        .padding(.leading, 400)
                    
                    VStack(alignment: .trailing) {
                        ForEach(messages, id: \.self) { message in
                            Text(message)
                                .padding()
                                .background(Color("basicWhite"))
                                .foregroundColor(.black)
                                .cornerRadius(30)
                                .padding(.bottom, 20)
                        }
                    }.padding(.leading, 400)
                    
                    HStack {
                        TextField("Type a message", text: $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: sendMessage) {
                            Image(systemName: "arrow.up.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing)
                        }
                    }
                }
                
                
            }
            
        }
        
    }
    
    func sendMessage() {
        if !text.isEmpty {
            messages.append(text)
            text = ""
        }
    }
    
}

struct AIChatView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatView()
    }
}
