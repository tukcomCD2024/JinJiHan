//
//  RecentNewsViewModel.swift
//  RollTheDice
//
<<<<<<< HEAD
//  Created by 신예진 on 6/19/24.
=======
//  Created by 신예진 on 6/20/24.
>>>>>>> DeviOS
//

import Foundation
import Combine
import Moya
import Combine

class RecentNewsViewModel: ObservableObject {
    @Published var news: [News] = []
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<RecentNewsService>()

    func fetchViewedHistory() {
        print("최근 읽은 뉴스 조회 요청 시작")
        provider.requestPublisher(.getViewedHistory)
            .map([News].self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("최근 읽은 뉴스 조회 실패 - 에러: \(error)")
                case .finished:
                    print("최근 읽은 뉴스 조회 완료")
                }
            }, receiveValue: { [weak self] news in
                self?.news = news
                for item in news {
                    print("최근 읽은 뉴스 조회 성공 - 뉴스 id: \(item.id), 뉴스 제목: \(item.title)")
                }
            })
            .store(in: &cancellables)
    }
}
