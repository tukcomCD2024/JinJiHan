//
//  ChatInteractorProtocol.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import Foundation
import Combine
import ExyteChat

protocol ChatInteractorProtocol {
    var messages: AnyPublisher<[MockMessage], Never> { get }
    var senders: [MockUser] { get }
    var otherSenders: [MockUser] { get }

    func send(draftMessage: ExyteChat.DraftMessage)

    func connect()
    func disconnect()

    func loadNextPage() -> Future<Bool, Never>
}
