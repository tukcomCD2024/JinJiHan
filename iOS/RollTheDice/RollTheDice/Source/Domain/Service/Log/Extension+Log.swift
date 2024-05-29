//
//  Extension+Log.swift
//  RollTheDice
//
//  Created by Subeen on 5/14/24.
//

import Foundation

public extension Log {
    //MARK: -  디버그
    static func debug(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .debug)
    }

    //MARK: - 문제 해결시 활용할 수 있는, 도움이 되지만 필수적이지 않은 정보  로거
    /**
     # info
     - Authors : suni
     - Note : 문제 해결시 활용할 수 있는, 도움이 되지만 필수적이지 않은 정보
     */
    static func info(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .info)
    }
   
    
    //MARK: -  네트워크 로거
    static func network(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .network)
    }
    
    //MARK: -  에러 로거
    static func error(_ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .error)
    }

    //MARK: -  커스텀 로거
    static func custom(category: String, _ message: Any, _ arguments: Any...) {
        log(message, arguments, level: .custom(category: category))
    }
    
}

