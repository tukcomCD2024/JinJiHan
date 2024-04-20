//
//  APIHeaderManager.swift
//  RollTheDice
//
//  Created by Subeen on 3/21/24.
//

import Foundation

public class APIHeaderManger {
    
    static let shared = APIHeaderManger()

    let contentType: String = "application/json"
    let rtdHost: String = "localhost:8080"
}
