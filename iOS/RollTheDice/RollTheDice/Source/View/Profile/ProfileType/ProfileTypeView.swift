//
//  ProfileTypeView.swift
//  RollTheDice
//
//  Created by 신예진 on 3/13/24.
//

import SwiftUI

struct ProfileTypeView: View {
    @State var isuserSelected: Bool = false
    @State var issettingSelected: Bool = false
    
    var body: some View {
        ZStack {
                    Color.backgroundDark.ignoresSafeArea(.all)
                    ProfileTypeContentView(isuserSelected: $isuserSelected, issettingSelected: $issettingSelected)
                    if isuserSelected {
                        ProfileView()
                    }
                    if issettingSelected {
                        SettingView()
                    }
                }
    }
    
    private struct ProfileTypeContentView: View {
        
        @Binding var isuserSelected: Bool
        @Binding var issettingSelected: Bool
        
        fileprivate var body: some View {
            HStack {
                Button {
                    isuserSelected.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.primary01)
                        .frame(width: 350, height: 400)
                        
                        .overlay {
                            VStack {
                                HStack {
                                    Text("회원정보")
                                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundStyle(.basicWhite)

                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    Text("👤")
                                        .font(.system(size: 100))
                                }
                            }
                            .padding(.horizontal, 35)
                            .padding(.bottom, 35)
                            .padding(.top, 45)
                            

                        }
                }
                
                Button {
                    issettingSelected.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.gray01)
                        .frame(width: 350, height: 400)
                        
                        .overlay {
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("설정")
                                        .multilineTextAlignment(.trailing)
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundStyle(.primary01)
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Text("⚙️")
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
    ProfileTypeView()
}
