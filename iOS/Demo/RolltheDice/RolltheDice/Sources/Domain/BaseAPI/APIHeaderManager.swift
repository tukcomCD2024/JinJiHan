//
//  APIHeaderManager.swift
//  Scoop
//
//  Created by Subeen on 9/5/24.
//

import Foundation

public class APIHeaderManager {
    
    static let shared = APIHeaderManager()

    let authorization: String = "Authorization"
    let scoopHost: String = "roll-the-dice.store:8080"
}
