//
//  GPTChatViewModel.swift
//  RollTheDice
//
//  Created by Subeen on 3/20/24.
//

import Foundation

class GPTChatViewModel: ObservableObject {
    @Published var chat: GPTChat
    
    init(chat: GPTChat) {
        self.chat = chat
    }
}
