//
//  Date + Ext.swift
//  ToDo
//
//  Created by Александр Андреев on 28.06.2024.
//

import Foundation
extension Date {
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}
