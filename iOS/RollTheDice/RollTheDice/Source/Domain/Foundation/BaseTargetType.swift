//
//  BaseTargetType.swift
//  RollTheDice
//
//  Created by Subeen on 3/21/24.
//

import Foundation
import Moya

public protocol BaseTargetType: TargetType {}


extension BaseTargetType {
    public var baseURL: URL {
        return URL(string: RollTheDiceAPI.baseURL)!
    }
    
    public var headers: [String : String]? {
        return APIConstants.baseHeader
    }
    
}
