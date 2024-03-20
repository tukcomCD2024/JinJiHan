//
//  NewsListViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 2/9/24.
//

import Foundation

public class NewsListViewModel: ObservableObject {
    @Published var newsList: [News]
    
    init(
        newsList: [News] = [
            .init(title: "네이버, 사우디 'LEAP 2024'서 AI·로봇 등 자사 기술력 뽐낸다", date: "2023년3월3일", image: "https://imgnews.pstatic.net/image/008/2024/03/05/0005007355_001_20240305100101016.jpg?type=w647", content: "네이버(NAVER)는 사우디아라비아에서 지난 4일부터 7일까지 열리는 글로벌 IT전시회 LEAP 2024에서 AI(인공지능), 클라우드, 로봇 등 자사 핵심 기술을 선보이고, 글로벌 업체들과 비즈니스 협력을 강화한다고 5일 밝혔다.", isBookmarked: false),
            .init(title: "앤스로픽 최신 AI 모델 '클로드3' 출시", date: "2023년3월13일", image: "https://imgnews.pstatic.net/image/014/2024/03/05/0005151141_001_20240305101610000.jpg?type=w647", content: "오픈AI의 대항마 앤스로픽이 생성형 인공지능(AI) 최신 모델 '클로드'(Claude)3를 선보이면서 생성형 AI 주도권을 잡기 위한 경쟁이 다시 뜨거워지고 있다. 앤스로픽은 지난 한 해 동안 구글과 세일즈포스, 아마존 등에서 총 73억 달러(약 9조7309억 원)를 투자받고 '클로드3'를 내놨는데 오픈AI의 챗GPT-4를 능가한다고 도발했다.", isBookmarked: true),
            .init(title: "SK C&C, 외부 전문가 대거 영입… “신성장 동력 강화”", date: "2023년2월13일", image: "https://imgnews.pstatic.net/image/366/2024/03/05/0000975131_001_20240305093504301.jpg?type=w647", content: "SK C&C는 국내외 신성장 동력 강화를 위해 인공지능(AI)·클라우드·디지털 팩토리·ESG(환경·사회·지배구조) 등 4대 성장 사업과 디지털 컨설팅 중심으로 외부 전문가를 대거 영입해 전진 배치했다고 5일 밝혔다.", isBookmarked: false),
            .init(title: "NHN, 작년 영업익 555억원...전년비 42% ↑", date: "2023년2월13일", image: "https://cdnimage.dailian.co.kr/news/202402/news_1707866329_1327972_m_1.png", content: "2NHN은 연결기준 지난해 영업이익이 555억원으로 전년 대비 42.2% 증가했다고 14일 밝혔다.같은 기간 매출은 7.3% 증가한 2조2696억원으로 연간 최대치를 기록했다. 작년 4분기 매출은 5983억원으로 전년 동기 대비 6.7% 올랐다. 반면 영업손실은 78억원으로 적자전환했다. 커머스 부문의 장기 미회수채권 대손상각비 인식과 기술 부문의 기 인식 매출 차감 등 일회성 요인이 영향을 미쳤다.", isBookmarked: false),
        ]
    ) {
        self.newsList = newsList
    }
}

extension NewsListViewModel {
    
}
