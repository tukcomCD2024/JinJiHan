//
//  DebatesService.swift
//  RollTheDice
//
//  Created by 신예진 on 6/18/24.
//

import Foundation
import Moya

class DebatesService {
    let provider = debatesProvider
    
    func getAllDebates(page: Int, size: Int, sort: String, completion: @escaping (Result<[Debate], Error>) -> Void) {
        provider.request(.getAllDebates(page: page, size: size, sort: sort)) { result in
            switch result {
            case .success(let response):
                do {
                    let debates = try JSONDecoder().decode([Debate].self, from: response.data)
                    completion(.success(debates))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createDebate(topic: String, completion: @escaping (Result<Debate, Error>) -> Void) {
        provider.request(.createDebate(topic: topic)) { result in
            switch result {
            case .success(let response):
                do {
                    let debate = try JSONDecoder().decode(Debate.self, from: response.data)
                    completion(.success(debate))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // 다른 엔드포인트에 대한 메소드 함수로 만들어두기
    
}
