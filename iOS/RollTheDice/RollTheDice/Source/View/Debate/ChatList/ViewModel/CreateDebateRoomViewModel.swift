//
//  CreateDebateRoomViewModel.swift
//  RollTheDice
//
//  Created by 신예진 on 6/19/24.
//

import Foundation
import Moya
import Combine

class CreateDebateRoomViewModel: ObservableObject {
    private let provider = MoyaProvider<CreateDebateRoomService>()
    @Published var debateID: Int?
    @Published var errorMessage: String?
    
    func createDebate(topic: String) {
        print("API 호출 시작 - 토론 주제: \(topic)")
        provider.request(.createDebate(topic: topic)) { result in
            switch result {
            case .success(let response):
                print("API 호출 성공 - 응답 코드: \(response.statusCode)")
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                    if let id = json?["id"] as? Int {
                        DispatchQueue.main.async {
                            self.debateID = id
                            print("토론방 생성 성공 - ID: \(id)")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to parse response"
                        print("응답 파싱 중 에러: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("API 호출 실패 - 에러: \(error.localizedDescription)")
                }
            }
        }
    }
}
