//
//  SignUpViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/10/24.
//

import Foundation

@Observable class SignUpViewModel: ObservableObject {
    var hasDoneTest = false
    var nickname: String?
    var questions : [Question] = [
        .init(question: "닉네임을 입력해주세요.", nickname: "", page: 0),
        .init(question: "연령대를 선택해주세요.", options: ["10대", "20대", "30대", "40대", "50대 이상"], page: 1),
        .init(question: "성별을 입력해주세요", options: ["여성", "남성", "밝히지 않음"], page: 2),
        .init(question: "선호하는 기사 주제를 선택해주세요.", options: ["정치", "자연과학", "경제", "IT/과학", "생활/문화", "세계"], page: 3),
        .init(question: "뉴스 보는 주기를 선택해주세요.", options: ["매일", "3일에 1번", "1주일에 1번", "거의 안 봄"], page: 4),
        .init(question: "앱을 사용하는 목적을 선택해주세요.", options: ["시사 상식 채우기", "심심풀이", "밝히지 않음"], page: 6),
    ]
}



struct Question: Hashable {

    var question: String
    var options: [String] = []
    var nickname: String?
    var page: Int
}

