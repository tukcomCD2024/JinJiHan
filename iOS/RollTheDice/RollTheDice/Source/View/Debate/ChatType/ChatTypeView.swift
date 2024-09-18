////
////  ChatTypeView.swift
////  RollTheDice
////
////  Created by Subeen on 2/14/24.
////
//
//import SwiftUI
//
//struct ChatTypeView: View {
//    @EnvironmentObject private var pathModel: PathModel
////    @State var isSelected: Bool = false
//    
//    var body: some View {
//        ZStack {
//            Color.backgroundDark.ignoresSafeArea(.all)
//            VStack {
//
//                
//
//            }
//            
//        }
//    }
//    
//    var recentReadNewsView: some View {
//        VStack(alignment: .leading) {
//            Text("최근에 본 뉴스")
//                .foregroundStyle(.gray01)
//                .font(.pretendardBold32)
//            HStack {
//                Button {
//                    //                    isSelected.toggle()
//                    //                    pathModel.paths.append(.chatView(isAiMode: true))
//                } label: {
//                    RoundedRectangle(cornerRadius: 15)
//                        .foregroundStyle(.primary01)
//                        .frame(width: 200, height: 200)
//                    
//                        .overlay {
//                            VStack {
//                                HStack {
//                                    Text("기사제목")
//                                        .multilineTextAlignment(.leading)
//                                        .font(.pretendardBold24)
//                                        .foregroundStyle(.basicWhite)
//                                }
//                            }
//                        }
//                }
//                
//                Button {
//                    //                    isSelected.toggle()
//                    //                    pathModel.paths.append(.chatView(isAiMode: true))
//                } label: {
//                    RoundedRectangle(cornerRadius: 15)
//                        .foregroundStyle(.primary01)
//                        .frame(width: 200, height: 200)
//                    
//                        .overlay {
//                            VStack {
//                                HStack {
//                                    Text("기사제목")
//                                        .multilineTextAlignment(.leading)
//                                        .font(.pretendardBold24)
//                                        .foregroundStyle(.basicWhite)
//                                }
//                            }
//                        }
//                }
//                
//                Button {
//                    //                    isSelected.toggle()
//                    //                    pathModel.paths.append(.chatView(isAiMode: true))
//                } label: {
//                    RoundedRectangle(cornerRadius: 15)
//                        .foregroundStyle(.primary01)
//                        .frame(width: 200, height: 200)
//                    
//                        .overlay {
//                            VStack {
//                                HStack {
//                                    Text("기사제목")
//                                        .multilineTextAlignment(.leading)
//                                        .font(.pretendardBold24)
//                                        .foregroundStyle(.basicWhite)
//                                }
//                            }
//                        }
//                }
//            }
//        }
//    }
//    
//    var chatListView: some View {
//        VStack(alignment: .leading) {
//            
//            Text("채팅 목록")
//                .foregroundStyle(.gray01)
//                .font(.pretendardBold32)
//        
//            ScrollView {
//                HStack {
//                    Button {
//                        //                    isSelected.toggle()
//                        //                    pathModel.paths.append(.chatView(isAiMode: true))
//                    } label: {
//                        RoundedRectangle(cornerRadius: 15)
//                            .foregroundStyle(.primary01)
//                            .frame(width: 600, height: 100)
//                        
//                            .overlay {
//                                HStack {
//                                    Text("기사제목")
//                                        .multilineTextAlignment(.leading)
//                                        .font(.pretendardBold24)
//                                        .foregroundStyle(.basicWhite)
//                                    
//                                    Spacer()
//                                    
//                                    
//                                }
//                            }
//                    }
//                    Button {
//                        pathModel.paths.append(.debateSummaryView(roomId: <#T##Int#>))
//                    } label: {
//                        
//                        Image(.chevronRight)
//                            .padding(10)
//                            .background(.basicBlack)
//                    }
//                }
//            }
//        }
//    }
//    
//}
//
//#Preview {
//    ChatTypeView()
//        .environmentObject(PathModel())
//}
