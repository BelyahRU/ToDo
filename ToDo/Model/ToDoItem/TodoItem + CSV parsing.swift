//
//  TdoItem + CSV parsing.swift
//  ToDo
//
//  Created by Александр Андреев on 21.06.2024.
//

import Foundation
extension TodoItem {
    
    static let regex = #"(?!\B"[^"]*),(?![^"]*"\B)"# // регулярное выражение
    
    var csv: String {
        var columns: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        columns.append(id)
        columns.append("\"\(text)\"")
        columns.append(importance.rawValue)
        columns.append("\(isTaskDone)")
        columns.append(DateHelper.getStringFromDate(date: creationDate, dateFormatter: dateFormatter)!)
        columns.append(DateHelper.getStringFromDate(date: modifiedDate, dateFormatter: dateFormatter) ?? "")
        columns.append(DateHelper.getStringFromDate(date: deadline, dateFormatter: dateFormatter) ?? "")
        return columns.joined(separator: ",")
    }
    
    static func parse(csv: String) -> TodoItem? {
        let columns = String.customSplit(text: csv, regexStr: regex)//используем кастомный сплит с регулярным выражением, т.к. csv файл разделяется на запятые, но в text могут быть тоже запятые, поэтому text у меня обраблен кавычками и благодаря регулярному выражению и этой функции запятые, которые находяся в кавычках не будут "заспличены"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if columns.count == ToDoDictionaryKeys.allCases.count {
            
            let id = columns[0]
            let text = columns[1]
            let importanceStr = columns[2]
            let isTaskDone = columns[3].lowercased() == "true"
            let creationDate = columns[4]
            let modifiedDate = columns[5].isEmpty ? nil : columns[5]
            let deadline = columns[6].isEmpty ? nil : columns[6]
            let importance = Importance(rawValue: importanceStr) ?? Importance.ordinary
            
            return TodoItem(id: id, text: text, importance: importance, deadline: DateHelper.getDateFromString(stringDate: deadline, dateFormatter: dateFormatter), isTaskDone: isTaskDone, creationDate: DateHelper.getDateFromString(stringDate: creationDate, dateFormatter: dateFormatter)!, modifiedDate: DateHelper.getDateFromString(stringDate: modifiedDate, dateFormatter: dateFormatter))
        } else {
            print("CSV parse error")
            return nil
        }
    }
    
}
