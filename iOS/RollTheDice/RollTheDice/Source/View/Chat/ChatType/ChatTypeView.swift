//
//  ChatTypeView.swift
//  RollTheDice
//
//  Created by Subeen on 2/14/24.
//

import SwiftUI

struct ChatTypeView: View {
    @State var isSelected: Bool = false
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            ChatTypeContentView(isSelected: $isSelected)
            if isSelected {
                AIChatView()
            }
        }
    }
    
    private struct ChatTypeContentView: View {
        
        @Binding var isSelected: Bool
        
        fileprivate var body: some View {
            HStack {
                Button {
                    isSelected.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.primary01)
                        .frame(width: 350, height: 400)
                        
                        .overlay {
                            VStack {
                                HStack {
                                    Text("Chat GPT랑\n토론하기")
                                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundStyle(.basicWhite)

                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    Text("🤖")
                                        .font(.system(size: 100))
                                }
                            }
                            .padding(.horizontal, 35)
                            .padding(.bottom, 35)
                            .padding(.top, 45)
                            

                        }
                }
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.gray01)
                        .frame(width: 350, height: 400)
                        
                        .overlay {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("인간이랑\n토론하기")
                                        .multilineTextAlignment(.trailing)
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundStyle(.primary01)
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Text("🫶")
                                        .font(.system(size: 100))
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 35)
                            .padding(.bottom, 35)
                            .padding(.top, 45)
                        }
                }
            }
        }
    }
}

#Preview {
    ChatTypeView()
}
