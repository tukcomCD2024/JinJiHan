//
//  DailyReportModel.swift
//  RollTheDice
//
//  Created by Subeen on 4/28/24.
//

import Foundation
import SwiftUI

struct DailyReportList: Hashable {
    var reportList: [DailyReport]
}

struct DailyReport: Hashable, Identifiable {
    let id = UUID()
    let dateStr: String // DateFormatter로 변환
    let views: Int
    
    var date: Date {
        // TODO: Format Style 사용해서 String -> Date 생성하기
//        let strategy = Date.ParseStrategy(format: "\(month: .twoDigits)년 \(month: .twoDigits)월 \(day: .defaultDigits)", timeZone: TimeZone(abbreviation: "CDT")!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let convertedDate = dateFormatter.date(from: dateStr)!
        
        return convertedDate
    }
}
