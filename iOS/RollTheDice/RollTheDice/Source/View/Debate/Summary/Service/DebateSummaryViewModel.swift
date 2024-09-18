//
//  DebateSummaryViewModel.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation
import Combine
import Moya

class DebateSummaryViewModel: ObservableObject {
    @Published var summary: DebateSum?
    @Published var roomId: Int?
//    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<DebateService>(plugins: [MoyaLoggingPlugin()])
    
    // 토론 요약
    func getDebateSummary(roomId: Int) {
        
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        provider.requestPublisher(.getDebatesSum(roomId: roomId, accessToken: accessToken))
            .map(DebateSum.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("토론 요약 실패 - 에러: \(error)")
                case .finished:
                    print("토론 요약 완료")
                }
            }, receiveValue: { [weak self] sum in
                self?.summary = sum
            })
            .store(in: &cancellables)
    }
}
