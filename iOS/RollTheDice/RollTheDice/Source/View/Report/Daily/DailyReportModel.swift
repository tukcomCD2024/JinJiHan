//
//  DailyReportModel.swift
//  RollTheDice
//
//  Created by Subeen on 4/28/24.
//

import Foundation
import SwiftUI

//struct DailyReportList: Codable {
//    var reportList: [DailyReport]
//}

struct DailyReport: Codable, Identifiable {
    
    let id = UUID().uuidString
    let views: Int?
    let dateTime: String?
    
    var date: Date {
        // TODO: Format Style 사용해서 String -> Date 생성하기
//        let strategy = Date.ParseStrategy(format: "\(month: .twoDigits)년 \(month: .twoDigits)월 \(day: .defaultDigits)", timeZone: TimeZone(abbreviation: "CDT")!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertedDate = dateFormatter.date(from: dateTime ?? "0000-00-00")
        
        return convertedDate!
    }
}
