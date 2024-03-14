//
//  AIChatView.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import SwiftUI

struct AIChatView: View {
    
    @EnvironmentObject var pathModel: PathModel
    @State private var text: String = ""
    @State private var messages: [String] = []
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            VStack {
                CustomNavigationBar(leftBtnAction: {
                    [pathModel.paths.removeLast()]
                })
                HStack {
                    ScrollView(showsIndicators: false) {
                        AIChatTitleView()
                    }
                    
                    VStack {
                        ScrollView{
                            
                            HStack {
                                Spacer()
                                
                                VStack {
                                    HStack {
                                        AIChatCustomView()
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        MyChatCustomView()
                                    }
                                    
                                    VStack(alignment: .trailing) {
                                        HStack {
                                            Spacer()
                                            VStack {
                                                ForEach(messages, id: \.self) { message in
                                                    Text(message)
                                                        .padding()
                                                        .background(.basicWhite)
                                                        .foregroundColor(.black)
                                                        .cornerRadius(30)
                                                        .padding(.bottom, 20)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                        
                        VStack {
                            
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
            .environmentObject(PathModel())
    }
}
