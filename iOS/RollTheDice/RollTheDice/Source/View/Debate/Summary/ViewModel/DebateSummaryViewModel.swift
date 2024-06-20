//
//  DebateSummaryViewModel.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation
import Combine
import Moya

//class DebateSummaryViewModel: ObservableObject {
//    @Published var summary: String?
//    @Published var roomId: Int?
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String?
//    
//    private let provider = MoyaProvider<DebateSummaryService>()
//    
//    func fetchSummary(roomId: Int) {
//        isLoading = true
//        provider.request(.getSummary(roomId: roomId)) { result in
//            self.isLoading = false
//            switch result {
//            case .success(let response):
//                do {
//                    let json = try JSONSerialization.jsonObject(with: response.data, options: [])
//                    if let dict = json as? [String: Any], let summary = dict["summary"] as? String {
//                        self.summary = summary
//                        self.roomId = roomId
//                        print("토론 요약 성공")
//                    } else {
//                        self.errorMessage = "Invalid response format"
//                        print("토론 요약 유효하지 않은 포맷")
//                    }
//                } catch {
//                    self.errorMessage = "Failed to parse response"
//                    print("토론 요약 reponse 못 받아옴")
//                }
//            case .failure(let error):
//                self.errorMessage = error.localizedDescription
//                print("토론 요약 오류/실패")
//            }
//        }
//    }
//}

class DebateSummaryViewModel: ObservableObject {
    @Published var summaryDebate: SummaryDebate?
    private let provider = MoyaProvider<DebateSummaryService>()
    
    func fetchDebateSummary(roomId: Int) {
        print("fetchDebateSummary : 토론 요약 함수 실행되니?")
        provider.request(.summary(roomId: roomId)) { result in
            switch result {
            case .success(let response):
                print("토론 요약 함수 성공해서 이제 요약할 거임!")
                do {
                    let decoder = JSONDecoder()
                    let summaryDebate = try decoder.decode(SummaryDebate.self, from: response.data)
                    DispatchQueue.main.async {
                        self.summaryDebate = summaryDebate
                    }
                    print("Summary: \(summaryDebate.summary ?? "No summary")")
                    print("토론 요약할 게 없어!")
                } catch {
                    print("Failed to parse response: \(error.localizedDescription)")
                    print("토론 요약 Response fail...")
                }
            case .failure(let error):
                print("API request failed: \(error.localizedDescription)")
                print("토론 요약 API request failed...")
            }
        }
    }
}
