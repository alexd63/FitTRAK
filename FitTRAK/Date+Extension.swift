//
//  Date+Extension.swift
//  FitTRAK
//
//  Created by Alex Diaz on 4/28/23.
//

import Foundation

extension Date {
    static func firstDayOfWeek() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
    }
}
