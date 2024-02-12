//
//  BookmarkListViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 2/12/24.
//

import Foundation

public class BookmarkListViewModel: ObservableObject {
    @Published var bookmarkList: [Bookmark]
    
    init(
        bookmarkList: [Bookmark] = [
            .init(title: "2024년 ‘소셜 미디어 다이어트’를 위해 바꿔볼 것", date: "2023년12월3일", image: "exampleNews", content: "2024년으로 접어든지 한 달이 넘었다. 하지만 올 해가 어떻게 흘러갈지 예측하기는 쉽지 않다. 한 가지 확실한 것은 정치적으로 매우 중요한 해라는 점이다. 미국과 러시아, 우크라이나, 방글라데시, 인도, 대만, 한국, 남아프리카공화국, 유럽의회, 영국에서 선거가 치러질 예정이다.", isBookmarked: false),
            .init(title: "2024년 ‘소셜 미디어 다이어트’를 위해 바꿔볼 것", date: "2023년12월3일", image: "exampleNews", content: "2024년으로 접어든지 한 달이 넘었다. 하지만 올 해가 어떻게 흘러갈지 예측하기는 쉽지 않다. 한 가지 확실한 것은 정치적으로 매우 중요한 해라는 점이다. 미국과 러시아, 우크라이나, 방글라데시, 인도, 대만, 한국, 남아프리카공화국, 유럽의회, 영국에서 선거가 치러질 예정이다.", isBookmarked: false),
            .init(title: "2024년 ‘소셜 미디어 다이어트’를 위해 바꿔볼 것", date: "2023년12월3일", image: "exampleNews", content: "2024년으로 접어든지 한 달이 넘었다. 하지만 올 해가 어떻게 흘러갈지 예측하기는 쉽지 않다. 한 가지 확실한 것은 정치적으로 매우 중요한 해라는 점이다. 미국과 러시아, 우크라이나, 방글라데시, 인도, 대만, 한국, 남아프리카공화국, 유럽의회, 영국에서 선거가 치러질 예정이다.", isBookmarked: false),
            .init(title: "2024년 ‘소셜 미디어 다이어트’를 위해 바꿔볼 것", date: "2023년12월3일", image: "exampleNews", content: "2024년으로 접어든지 한 달이 넘었다. 하지만 올 해가 어떻게 흘러갈지 예측하기는 쉽지 않다. 한 가지 확실한 것은 정치적으로 매우 중요한 해라는 점이다. 미국과 러시아, 우크라이나, 방글라데시, 인도, 대만, 한국, 남아프리카공화국, 유럽의회, 영국에서 선거가 치러질 예정이다.", isBookmarked: false),
        ]
    ) {
        self.bookmarkList = bookmarkList
    }
}
