//
//  GetDebateRoomViewModel.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation
import Combine
import Moya

class GetDebateRoomViewModel: ObservableObject {
    @Published var debates: [DebateRoom] = []
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<GetDebateRoomService>()
    
    func fetchDebates(page: Int, size: Int) {
        provider.requestPublisher(.getDebates(page: page, size: size))
            .map(\.data)
            .decode(type: [DebateRoom].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching debates: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] debates in
                self?.debates = debates
                print("Fetched debates: \(debates)") // 로그 확인용
            })
            .store(in: &cancellables)
    }
}
