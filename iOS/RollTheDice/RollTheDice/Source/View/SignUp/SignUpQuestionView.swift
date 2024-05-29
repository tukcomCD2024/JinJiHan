//
//  SignUpViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/10/24.
//

import SwiftUI

struct SignUpQuestionView: View {

    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var viewModel: SignUpViewModel
    @State var process: Int = 0
    @State var isSelected: Bool = false
    @State var nickname: String = ""
    
    @State var selectedQuestionNumber: Int?
    
    var body: some View {
        if viewModel.hasDoneTest {
            SignUpFinishView()
        } else {
            VStack {
                CustomNavigationBar()
                processView
                Spacer()
                
                VStack {
                    Spacer()
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    questionView
                    Spacer()
                    nextButtonView
                }
                .padding(.horizontal, 150)
            }
        }
    }
    
    var processView: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(height: 10)
                HStack {
                    Rectangle()
                        .frame(width: CGFloat(process) * 180 ,height: 10)
                        .foregroundStyle(.primary01)
                        .animation(.bouncy, value: process)
                    Spacer()
                }
            }
        }
    }
    
    var questionView: some View {
        VStack {
            HStack {
                Text(viewModel.questions[process].question)
                    .font(.pretendardBold40)
                    .foregroundStyle(.basicWhite)
                
                Spacer()
            }
            
            if process != 0 {
                HStack(spacing: 10) {
                    ForEach(viewModel.questions[process].options.indices, id: \.self) { q in
                        Button {
                            selectedQuestionNumber = q
                            isSelected = true
                        } label: {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(q == selectedQuestionNumber ? .primary01 : .basicWhite)
                                .frame(height: 200)
                                .overlay {
                                    Text(viewModel.questions[process].options[q])
                                        .foregroundStyle(.basicWhite)
                                        .font(.pretendardBold24)
                                }
                        }
                    }
                }
            } else {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.clear)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .strokeBorder(Color.primary01, lineWidth: 2)
                    }
                    .frame(height: 100)
                    .overlay {
                        TextField(
                            "현재 닉네임",
                            text: self.$nickname,
                            prompt: Text("이름을 입력하세요").foregroundStyle(.white).font(.pretendardBold24)
                        )
                        .padding(30)
                }
            }
        }
        .onChange(of: nickname) {
            if nickname != "" {
                isSelected = true
            } else {
                isSelected = false
            }
        }
        .onChange(of: process) {
            if process < 6 && process > -1 {
                selectedQuestionNumber = -1
                isSelected = false
            } else if process == 6 {
                viewModel.hasDoneTest = true
            }
        }
    }
    
    var nextButtonView: some View {
        Button {
            if process < 5 {
                process += 1
            } else {
                viewModel.hasDoneTest = true
            }
        } label: {
      
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 80)
                .foregroundStyle(isSelected ? .primary01 : .gray05)
                
                .overlay {
                    Text("확인")
                        .foregroundStyle(.basicWhite)
                }
        }
        .disabled(!isSelected)
    }
    
}


#Preview {
    SignUpQuestionView()
        .environmentObject(SignUpViewModel())
        .environmentObject(AuthenticationViewModel())
}
