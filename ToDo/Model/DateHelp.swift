//
//  DateHelp.swift
//  ToDo
//
//  Created by Александр Андреев on 20.06.2024.
//

import Foundation
class DateHelper {
    static func getStringFromDate(date: Date?, dateFormatter: DateFormatter) -> String? {
        guard let date = date else { return nil }
        return dateFormatter.string(from: date)
    }

    static func getDateFromString(stringDate: String?, dateFormatter: DateFormatter) -> Date? {
        guard let stringDate = stringDate else { return nil }
        return dateFormatter.date(from: stringDate)
    }
}
