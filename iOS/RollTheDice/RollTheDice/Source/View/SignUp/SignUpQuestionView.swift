//
//  SignUpViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/10/24.
//

import SwiftUI

struct SignUpQuestionView: View {
    
//    @StateObject var p
    @StateObject var viewModel = SignUpViewModel()
    @State var process: Int = 1
    @State var isSelected: Bool = false
    
    var body: some View {
        if viewModel.hasDoneTest {
            
            SignUpFinishView()
        } else {
            VStack {
                CustomNavigationBar()
                ProcessView(process: $process)
                
                VStack {
                    Spacer()
                    QuestionView(viewModel: viewModel, process: $process, isSelected: $isSelected)
                    Spacer()
                    NextButtonView(process: $process, isSelected: $isSelected)
                }
                .padding(.horizontal, 15)
            }
        }
    }
    
    
}

private struct ProcessView: View {
    @Binding var process: Int
    
    fileprivate var body: some View {
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
}

private struct QuestionView: View {
    @ObservedObject var viewModel: SignUpViewModel
    @Binding var process: Int
    @State var question: String = ""
    @State var options: [String] = []
    @State var selection: Int = -1      /// 선택한 버튼의 index
    @Binding var isSelected: Bool
    
    fileprivate var body: some View {
        VStack {
            
            Spacer()
            HStack {
                Text(question)
                    .font(.largeTitle)
                    .foregroundStyle(.basicWhite)
                Spacer()
            }
            Spacer()
            HStack(spacing: 10) {
                ForEach(options.indices, id: \.self) { q in
                    Button {
                        selection = q
                        isSelected = true
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(q == selection ? .primary01 : .basicWhite)
                            .frame(height: 200)
                            .overlay {
                                Text(options[q])
                                    .font(.title)
                                    .foregroundStyle(.basicWhite)
                            }
                    }
                }
            }
            
            Spacer()
        }
        .onAppear(perform: {
            question = viewModel.questions[process].question
            options = viewModel.questions[process].options
        })
        .onChange(of: process) {
            if process < 6 && process > 1 {
                question = viewModel.questions[process].question
                options = viewModel.questions[process].options
                selection = -1
                isSelected = false
            } else if process == 6 {
                viewModel.hasDoneTest = true
            }
        }
    }
}

private struct NextButtonView: View {
    @Binding var process: Int
    @Binding var isSelected: Bool
    
    fileprivate var body: some View {
        Button {
            process += 1
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
}
