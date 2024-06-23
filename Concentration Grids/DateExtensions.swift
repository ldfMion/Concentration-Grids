//
//  DateExtensions.swift
//  Concentration Grids
//
//  Created by Lorenzo Mion on 17/05/24.
//

import Foundation

extension Date {
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
    func asRelativeNamed() -> String {
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.dateTimeStyle = .named
        return dateFormatter.localizedString(for: self, relativeTo: Date.now)
    }
}
