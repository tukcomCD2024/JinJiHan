//
//  APIHeaderManager.swift
//  RollTheDice
//
//  Created by Subeen on 3/21/24.
//

import Foundation

public class APIHeaderManager {
    
    static let shared = APIHeaderManager()

    let contentType: String = "application/json"
    let scoopHost: String = "ec2-13-124-191-244.ap-northeast-2.compute.amazonaws.com:8080"
}


// http://ec2-13-124-191-244.ap-northeast-2.compute.amazonaws.com:8080/swagger-ui/index.html
