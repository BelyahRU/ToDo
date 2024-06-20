//
//  TodoItem + JSON parsing.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import Foundation
extension TodoItem {
    
    private enum ToDoDictionaryKeys: String {
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
        dictionary[ToDoDictionaryKeys.id.rawValue] = id
        dictionary[ToDoDictionaryKeys.text.rawValue] = text
        dictionary[ToDoDictionaryKeys.isTaskDone.rawValue] = isTaskDone
        
        
        dictionary[ToDoDictionaryKeys.creationDate.rawValue] = Date.getStringFromDate(date: creationDate)
        
        if importance != .ordinary {
            dictionary[ToDoDictionaryKeys.importance.rawValue] = importance
        }
        
        if let deadline = deadline{
            dictionary[ToDoDictionaryKeys.deadline.rawValue] = Date.getStringFromDate(date: deadline)
        }
        
        if let modifiedDate = modifiedDate {
            dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] = Date.getStringFromDate(date: modifiedDate)
        }
        return dictionary
    }
    
    static func parse(json: Any) -> TodoItem? {
        
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
        
        //?
        let importanceStr = dictionary[ToDoDictionaryKeys.importance.rawValue] as? String ?? "обычная"
        
        guard let importance = Importance(rawValue: importanceStr) else {
            print("JSON parsing error.Importance not fount")
            return nil
        }
        
        guard let dateStr = dictionary[ToDoDictionaryKeys.creationDate.rawValue] as? String else {
            print("JSON parsing error.creationDate nil")
            return nil
        }
        
        guard let creationDate = Date.getDateFromString(stringDate: dateStr) else {
            print("JSON parsing error.creationDate nil")
            return nil
        }
        
        //If id is nil -> id = UUID().uuidString
        let id = dictionary[ToDoDictionaryKeys.id.rawValue] as? String ?? UUID().uuidString
        let deadline = Date.getDateFromString(stringDate: dictionary[ToDoDictionaryKeys.deadline.rawValue] as? String)
        let modifiedDate = Date.getDateFromString(stringDate: dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] as? String)
        
        
        let item = TodoItem(id: id, text: text, importance:  importance, deadline: deadline, isTaskDone: isTaskDone, creationDate: creationDate, modifiedDate: modifiedDate)

        return item
    }
}
