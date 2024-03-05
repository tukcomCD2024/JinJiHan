//
//  ChatError.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import Foundation

enum ChatError: Error {
    case unknown(source: Error?)
}
