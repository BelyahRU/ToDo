//
//  TodoItem + JSON parsing.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import Foundation
extension TodoItem {
    
    enum ToDoDictionaryKeys: String, CaseIterable {
        case id = "id"
        case text = "text"
        case importance = "importance"
        case deadline = "deadline"
        case isTaskDone = "isTaskDone"
        case creationDate = "creationDate"
        case modifiedDate = "modifiedDate"
    }
    
    var json: Any {
        var dictionary = [String: Any]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        dictionary[ToDoDictionaryKeys.id.rawValue] = id
        dictionary[ToDoDictionaryKeys.text.rawValue] = text
        dictionary[ToDoDictionaryKeys.isTaskDone.rawValue] = isTaskDone
        
        dictionary[ToDoDictionaryKeys.creationDate.rawValue] = DateHelper.getStringFromDate(date: creationDate, dateFormatter: dateFormatter)
        
        if importance != .ordinary {
            dictionary[ToDoDictionaryKeys.importance.rawValue] = importance
        }
        
        if let deadline = deadline{
            dictionary[ToDoDictionaryKeys.deadline.rawValue] = DateHelper.getStringFromDate(date: deadline, dateFormatter: dateFormatter)
        }
        
        //нужно ли сохранять modifiedFate если он nil?
        if let modifiedDate = modifiedDate {
            dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] = DateHelper.getStringFromDate(date: modifiedDate, dateFormatter: dateFormatter)
        }
        return dictionary
    }
    
    static func parse(json: Any) -> TodoItem? {
        if !JSONSerialization.isValidJSONObject(json) {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let data = try? JSONSerialization.data(withJSONObject: json) else {
                    return nil
                }
                
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }

        guard let text = dictionary[ToDoDictionaryKeys.text.rawValue] as? String else {
            print("JSON parsing error.text nil")
            return nil
        }
        
        guard let isTaskDone = dictionary[ToDoDictionaryKeys.isTaskDone.rawValue] as? Bool else {
            print("JSON parsing error.IsTaskDone nil")
            return nil
        }
        
        let importanceStr = dictionary[ToDoDictionaryKeys.importance.rawValue] as? String ?? "обычная"
        
        guard let importance = Importance(rawValue: importanceStr) else {
            print("JSON parsing error.Importance not fount")
            return nil
        }
        
        guard let dateStr = dictionary[ToDoDictionaryKeys.creationDate.rawValue] as? String else {
            print("JSON parsing error.creationDate nil")
            return nil
        }
        
        guard let creationDate = DateHelper.getDateFromString(stringDate: dateStr, dateFormatter: dateFormatter) else {
            print("JSON parsing error.creationDate nil")
            return nil
        }
        
        //If id is nil -> id = UUID().uuidString
        let id = dictionary[ToDoDictionaryKeys.id.rawValue] as? String ?? UUID().uuidString
        let deadline = DateHelper.getDateFromString(stringDate: dictionary[ToDoDictionaryKeys.deadline.rawValue] as? String, dateFormatter: dateFormatter)
        let modifiedDate = DateHelper.getDateFromString(stringDate: dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] as? String, dateFormatter: dateFormatter)
        
        print(creationDate)
        let item = TodoItem(id: id, text: text, importance:  importance, deadline: deadline, isTaskDone: isTaskDone, creationDate: creationDate, modifiedDate: modifiedDate)

        return item
    }
}
