//
//  DebateRoomViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 9/19/24.
//

import Foundation
import Moya
import Combine

/*
 case getDebates(page: Int, size: Int, accessToken: String)                        //  토론방 전체 조회
 case createDebates(topic: String, accessToken: String)
 case saveDebatesHuman(roomId: Int, message: String, accessToken: String)   // [인간] 토론 메세지 저장
 case saveDebatesAI(roomId: Int, message: String, accessToken: String)      // [AI] 토론 메세지 저장
 case getDebatesSum(roomId: Int, accessToken: String)
 case sumDebates(roomId: Int, accessToken: String)
 case getDebatesMsg(roomId: Int, accessToken: String)
 case deleteDebatesRoom(roomId: Int, accessToken: String)
 case endDebatesRoom(roomId: Int, accessToken: String)
 */

class DebateRoomViewModel: ObservableObject {
    var debateRoom: DebateRoom?
    
    private let provider = MoyaProvider<DebateService>(plugins: [MoyaLoggingPlugin()])
    
    var debateCancellable: AnyCancellable?
    var jsonDecoder = JSONDecoder()
}

extension DebateRoomViewModel {
    
    // 토론방 전체 조회
    func getDebates(page: Int, size: Int) {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        if let cancellable = debateCancellable {
            cancellable.cancel()
        }
        
        debateCancellable = provider.requestWithProgressPublisher(
            .getDebates(page: page, size: size, accessToken: accessToken)
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: DebateRoom.self, decoder: jsonDecoder)
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("debateChatRoom 조회성공")
            case .failure(let error):
                Log.network("debateChatRoom network error", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            self?.debateRoom = response
            print("debateChatRoom 결과값 \(response)")
        })
    }
    
    // 토론방 생성
    func createDebates(topic: String) {
        guard let accessToken = TokenManager.shared.accessToken else {
            print("Access token 사용 불가능...")
            return
        }
        
        if let cancellable = debateCancellable {
            cancellable.cancel()
        }
        
        debateCancellable = provider.requestWithProgressPublisher(
            .createDebates(topic: topic, accessToken: accessToken)
        )
        .compactMap { $0.response?.data }
        .receive(on: DispatchQueue.main)
        .decode(type: DebateChat.self, decoder: jsonDecoder)
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                print("createDebates 토론방 생성 성공")
            case .failure(let error):
                Log.network("createDebates network error", error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            print(response)
        })
    }
}
