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
            .init(title: "해외원정 가던 줄기세포치료 이젠 국내서도 받을 수 있다", date: "2023년2월13일", image: "exampleNews", content: "첨생법 개정안이 이달 1일 국회를 통과해 내년부터 시행된다. 이에 따라 식약처 허가 없이도 안전성·유효성이 확인되면 국내에서도 첨단재생의료 치료가 허용되고 모든 질환에 대한 임상연구가 가능해졌다. ", isBookmarked: false),
            .init(title: "홀로 선 자립준비청년, 배곯지 않게…우체국, 매일 식비 지원", date: "2023년2월13일",  content: "과학기술정보통신부 우정사업본부는 사회에 첫발을 내딛는 자립준비청년이 건강한 사회구성원으로 성장하도록 식비를 지원하는 '우체국 청년밥심 스타트 온(溫)' 사업을 확대 추진한다고 14일 밝혔다.", isBookmarked: false),
            .init(title: "NHN, 작년 영업익 555억원...전년비 42% ↑", date: "2023년2월13일", image: "exampleNews", content: "2NHN은 연결기준 지난해 영업이익이 555억원으로 전년 대비 42.2% 증가했다고 14일 밝혔다.같은 기간 매출은 7.3% 증가한 2조2696억원으로 연간 최대치를 기록했다. 작년 4분기 매출은 5983억원으로 전년 동기 대비 6.7% 올랐다. 반면 영업손실은 78억원으로 적자전환했다. 커머스 부문의 장기 미회수채권 대손상각비 인식과 기술 부문의 기 인식 매출 차감 등 일회성 요인이 영향을 미쳤다.", isBookmarked: false),
        ]
    ) {
        self.bookmarkList = bookmarkList
    }
}
