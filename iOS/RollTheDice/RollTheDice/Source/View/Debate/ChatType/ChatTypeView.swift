//
//  ChatTypeView.swift
//  RollTheDice
//
//  Created by Subeen on 2/14/24.
//

import SwiftUI

struct ChatTypeView: View {
    @EnvironmentObject private var pathModel: PathModel
    @State var isSelected: Bool = false
    
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea(.all)
            ChatTypeContentView(isSelected: $isSelected)
        }
    }
    
    private struct ChatTypeContentView: View {
        
        @Binding var isSelected: Bool
        @EnvironmentObject private var pathModel: PathModel
        
        fileprivate var body: some View {
            HStack {
                Button {
                    isSelected.toggle()
                    pathModel.paths.append(.chatView(isAiMode: true))
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.primary01)
                        .frame(width: 350, height: 400)
                        
                        .overlay {
                            VStack {
                                HStack {
                                    Text("Chat GPT랑\n토론하기")
                                        .multilineTextAlignment(.leading)
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
                    pathModel.paths.append(.chatView(isAiMode: false))
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
        .environmentObject(PathModel())
}
