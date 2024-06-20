//
//  EndDebateViewModel.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation
import Moya

class EndDebateViewModel: ObservableObject {
    private let provider = MoyaProvider<EndDebateService>()
    
    func endDebate(roomId: String, completion: @escaping (Bool) -> Void) {
        provider.request(.endDebate(roomId: roomId)) { result in
            switch result {
            case .success:
                print("토론 종료 성공")
                completion(true)
            case .failure:
                print("토론 종료 실패")
                completion(false)
            }
        }
    }
}
