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
    @Published var topic: String = ""

    
    func createDebate(topic: String, completion: @escaping (String) -> Void) {
        print("API 호출 시작 - 토론 주제: \(topic)")
        self.topic = topic // 토론 주제 저장
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
                            completion(topic) // 주제를 반환하여 초기 메시지 설정
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

