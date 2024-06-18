//
//  BookmarkListViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 2/12/24.
//

import Foundation
import Combine
import CombineMoya
import Moya
import SwiftUI

@Observable class BookmarksListViewModel{
    var bookmarksList: [Bookmarks]?
    var bookmarksCancellable: AnyCancellable?
    
    let provider = MoyaProvider<BookmarksService>(plugins: [MoyaLoggingPlugin()])
    
    func bookmarksToViewModel(_ list: [Bookmarks]) {
        self.bookmarksList = list
    }
}

extension BookmarksListViewModel {
    public func getAllBookmarksData(page: Int, size: Int) {
        let accessToken = "5Gu45OmOoZnvANl-qfZv-xHv_2eSweVeAAAAAQopyNkAAAGQFbGnJSn2EFsnJsRZ"
        
        if let cancellable = bookmarksCancellable {
            cancellable.cancel()
        }
        
        bookmarksCancellable = provider.requestWithProgressPublisher(
                .allBookmarks(
                    page: page,
                    size: size,
                    accessToken: accessToken
                )
        
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: [Bookmarks].self, decoder: JSONDecoder())
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("all bookmarks 조회 성공")
            case .failure(let error):
                Log.network("network error", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            self?.bookmarksToViewModel(response)
            print(response)
        })
    }
}
        
//public class BookmarksListViewModel: ObservableObject {
//    @Published var bookmarkList: [Bookmarks]
//    
//    init(
//        bookmarkList: [Bookmarks] = [
//            .init(title: "2024년 ‘소셜 미디어 다이어트’를 위해 바꿔볼 것", date: "2023년12월3일", image: "exampleNews", content: "2024년으로 접어든지 한 달이 넘었다. 하지만 올 해가 어떻게 흘러갈지 예측하기는 쉽지 않다. 한 가지 확실한 것은 정치적으로 매우 중요한 해라는 점이다. 미국과 러시아, 우크라이나, 방글라데시, 인도, 대만, 한국, 남아프리카공화국, 유럽의회, 영국에서 선거가 치러질 예정이다.", isBookmarked: false),
//            .init(title: "앤스로픽 최신 AI 모델 '클로드3' 출시", date: "2023년3월13일", image: "https://imgnews.pstatic.net/image/014/2024/03/05/0005151141_001_20240305101610000.jpg?type=w647", content: "오픈AI의 대항마 앤스로픽이 생성형 인공지능(AI) 최신 모델 '클로드'(Claude)3를 선보이면서 생성형 AI 주도권을 잡기 위한 경쟁이 다시 뜨거워지고 있다. 앤스로픽은 지난 한 해 동안 구글과 세일즈포스, 아마존 등에서 총 73억 달러(약 9조7309억 원)를 투자받고 '클로드3'를 내놨는데 오픈AI의 챗GPT-4를 능가한다고 도발했다.", isBookmarked: true),
//            .init(title: "SK C&C, 외부 전문가 대거 영입… “신성장 동력 강화”", date: "2023년2월13일", image: "https://imgnews.pstatic.net/image/366/2024/03/05/0000975131_001_20240305093504301.jpg?type=w647", content: "SK C&C는 국내외 신성장 동력 강화를 위해 인공지능(AI)·클라우드·디지털 팩토리·ESG(환경·사회·지배구조) 등 4대 성장 사업과 디지털 컨설팅 중심으로 외부 전문가를 대거 영입해 전진 배치했다고 5일 밝혔다.", isBookmarked: false),
//            .init(title: "NHN, 작년 영업익 555억원...전년비 42% ↑", date: "2023년2월13일", image: "https://cdnimage.dailian.co.kr/news/202402/news_1707866329_1327972_m_1.png", content: "2NHN은 연결기준 지난해 영업이익이 555억원으로 전년 대비 42.2% 증가했다고 14일 밝혔다.같은 기간 매출은 7.3% 증가한 2조2696억원으로 연간 최대치를 기록했다. 작년 4분기 매출은 5983억원으로 전년 동기 대비 6.7% 올랐다. 반면 영업손실은 78억원으로 적자전환했다. 커머스 부문의 장기 미회수채권 대손상각비 인식과 기술 부문의 기 인식 매출 차감 등 일회성 요인이 영향을 미쳤다.", isBookmarked: false),
//            
//            .init(title: "이종호 과기장관 5년 뒤 구축될 바이오파운드리에 산학연 역량 모아야", date: "2023년3월13일", image: "https://imgnews.pstatic.net/image/003/2024/03/05/NISI20231030_0001398722_web_20231030141808_20240305103108748.jpg?type=w647", content: "정부가 내년부터 합성생물학의 필수 인프라인 '국가 바이오파운드리' 구축에 본격 나서는 가운데 이종호 과학기술정보통신부 장관이 한국생명공학연구원에서 운영 중인 사전연구용 시설을 찾아 구체적인 인프라 구축 계획 등을 점검했다.이 장관은 5일 합성생물학 육성을 위해 바이오파운드리 연구현장을 방문하고, 산·학·연 전문가들을 만났다. 이번 방문은 지난해 미국, 영국과의 정상회담 시 논의됐던 첨단바이오 협력을 위한 후속조치의 일환으로 추진됐다.", isBookmarked: false),
//            .init(title: "SW산업 육성에 7308억 예산투자, SaaS 등 육성", date: "2023년3월13일", image: "https://imgnews.pstatic.net/image/008/2024/03/05/0005007507_001_20240305135301539.jpg?type=w647", content: "SW(소프트웨어) 산업의 SaaS(서비스형 소프트웨어) 전환 등 SW산업 육성을 위해 정부 예산 7308억원이 투자된다. 강도현 과학기술정보통신부 제2차관은 5일 오전 서울 을지로 더존비즈온 을지사옥에서 열린 'AI(인공지능) 일상화, SW도 이제 서비스형 SW'라는 주제로 열린 현장 간담회에서 정부도 대한민국 SW산업의 미래가 SaaS에 있다고 생각하고 올해 'SaaS 혁신펀드'를 새롭게 조성하는 등 SaaS 육성 및 기존 SW 기업의 SaaS 전환을 위해 다양한 지원을 추진 중이라며 이같이 밝혔다.", isBookmarked: false),
//            .init(title: "파수, 기업용 AI ‘엔터프라이즈 LLM’ 출시", date: "2023년3월13일", image: "https://imgnews.pstatic.net/image/018/2024/03/05/0005685566_001_20240305103201036.jpg?type=w647", content: "2NHN은 연결기준 지난해 영업이익이 555억원으로 전년 대비 42.2% 증가했다고 14일 밝혔다.같은 기간 매출은 7.3% 증가한 2조2696억원으로 연간 최대치를 기록했다. 작년 4분기 매출은 5983억원으로 전년 동기 대비 6.7% 올랐다. 반면 영업손실은 78억원으로 적자전환했다. 커머스 부문의 장기 미회수채권 대손상각비 인식과 기술 부문의 기 인식 매출 차감 등 일회성 요인이 영향을 미쳤다.", isBookmarked: false),
//            .init(title: "NHN, 작년 영업익 555억원...전년비 42% ↑", date: "2023년2월13일", image: "https://cdnimage.dailian.co.kr/news/202402/news_1707866329_1327972_m_1.png", content: "2NHN은 연결기준 지난해 영업이익이 555억원으로 전년 대비 42.2% 증가했다고 14일 밝혔다.같은 기간 매출은 7.3% 증가한 2조2696억원으로 연간 최대치를 기록했다. 작년 4분기 매출은 5983억원으로 전년 동기 대비 6.7% 올랐다. 반면 영업손실은 78억원으로 적자전환했다. 커머스 부문의 장기 미회수채권 대손상각비 인식과 기술 부문의 기 인식 매출 차감 등 일회성 요인이 영향을 미쳤다.", isBookmarked: false),
//            .init(title: "NHN, 작년 영업익 555억원...전년비 42% ↑", date: "2023년2월13일", image: "https://cdnimage.dailian.co.kr/news/202402/news_1707866329_1327972_m_1.png", content: "2NHN은 연결기준 지난해 영업이익이 555억원으로 전년 대비 42.2% 증가했다고 14일 밝혔다.같은 기간 매출은 7.3% 증가한 2조2696억원으로 연간 최대치를 기록했다. 작년 4분기 매출은 5983억원으로 전년 동기 대비 6.7% 올랐다. 반면 영업손실은 78억원으로 적자전환했다. 커머스 부문의 장기 미회수채권 대손상각비 인식과 기술 부문의 기 인식 매출 차감 등 일회성 요인이 영향을 미쳤다.", isBookmarked: false),
//            .init(title: "NHN, 작년 영업익 555억원...전년비 42% ↑", date: "2023년2월13일", image: "https://cdnimage.dailian.co.kr/news/202402/news_1707866329_1327972_m_1.png", content: "2NHN은 연결기준 지난해 영업이익이 555억원으로 전년 대비 42.2% 증가했다고 14일 밝혔다.같은 기간 매출은 7.3% 증가한 2조2696억원으로 연간 최대치를 기록했다. 작년 4분기 매출은 5983억원으로 전년 동기 대비 6.7% 올랐다. 반면 영업손실은 78억원으로 적자전환했다. 커머스 부문의 장기 미회수채권 대손상각비 인식과 기술 부문의 기 인식 매출 차감 등 일회성 요인이 영향을 미쳤다.", isBookmarked: false),
//        ]
//    ) {
//        self.bookmarkList = bookmarkList
//    }
//}
