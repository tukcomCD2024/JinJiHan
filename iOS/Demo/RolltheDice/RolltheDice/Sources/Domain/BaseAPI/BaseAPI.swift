//
//  BaseAPI.swift
//  Scoop
//
//  Created by Subeen on 9/5/24.
//

public enum BaseAPI: String {
    case base
    
    public var apiDesc: String {
        switch self {
        case .base:
            return "https://roll-the-dice.store:8080"
        }
    }
}
