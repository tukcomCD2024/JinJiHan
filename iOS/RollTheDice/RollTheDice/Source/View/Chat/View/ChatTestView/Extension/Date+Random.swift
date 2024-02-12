//
//  Date+Random.swift
//  RollTheDice
//
//  Created by 신예진 on 2/12/24.
//

import Foundation

extension Date {
    func randomTime() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.hour = Int.random(min: 0, max: 23)
        components.minute = Int.random(min: 0, max: 59)
        components.second = Int.random(min: 0, max: 59)

        return Calendar.current.date(from: components)!
    }
}
