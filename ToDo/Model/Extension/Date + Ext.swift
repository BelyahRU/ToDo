//
//  Date + Ext.swift
//  ToDo
//
//  Created by Александр Андреев on 20.06.2024.
//

import Foundation
extension Date {
    
    static func getStringFromDate(date: Date?) -> String? {
        guard let date else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func getDateFromString(stringDate: String?) -> Date?{
        guard let stringDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: stringDate)
    }
}
