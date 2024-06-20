//
//  News.swift
//  RollTheDice
//
//  Created by 신예진 on 6/20/24.
//

import Foundation

//MARK : 최근 읽은 뉴스 Model
struct News: Identifiable, Codable {
    let id: Int
    let title: String
}
