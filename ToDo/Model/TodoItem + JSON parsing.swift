//
//  TodoItem + JSON parsing.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import Foundation
extension TodoItem {
    
    private enum Keys: String {
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
        dictionary[Keys.id.rawValue] = id
        dictionary[Keys.text.rawValue] = text
        dictionary[Keys.isTaskDone.rawValue] = isTaskDone
        
        dictionary[Keys.creationDate.rawValue] = Date.getStringFromDate(date: creationDate)
        
        if importance != .ordinary {
            dictionary[Keys.importance.rawValue] = importance
        }
        
        if let deadline = deadline{
            dictionary[Keys.deadline.rawValue] = Date.getStringFromDate(date: deadline)
        }
        
        if let modifiedDate = modifiedDate {
            dictionary[Keys.modifiedDate.rawValue] = Date.getStringFromDate(date: modifiedDate)
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
        

        guard let text = dictionary[Keys.text.rawValue] as? String else {
            print("JSON parsing error.text nil")
            return nil
        }
        
        guard let isTaskDone = dictionary[Keys.isTaskDone.rawValue] as? Bool else {
            print("JSON parsing error.IsTaskDone nil")
            return nil
        }
        
        //?
        let importanceStr = dictionary[Keys.importance.rawValue] as? String ?? "обычная"
        
        guard let importance = Importance(rawValue: importanceStr) else {
            print("JSON parsing error.Importance not fount")
            return nil
        }
        
        guard let dateStr = dictionary[Keys.creationDate.rawValue] as? String else {
            print("JSON parsing error.creationDate nil")
            return nil
        }
        
        guard let creationDate = Date.getDateFromString(stringDate: dateStr) else {
            print("JSON parsing error.creationDate nil")
            return nil
        }
        
        let id = dictionary[Keys.id.rawValue] as? String ?? nil
        let deadline = Date.getDateFromString(stringDate: dictionary[Keys.deadline.rawValue] as? String)
        let modifiedDate = Date.getDateFromString(stringDate: dictionary[Keys.modifiedDate.rawValue] as? String)
        
        let item = TodoItem(id: id, text: text, importance:  importance, deadline: deadline, isTaskDone: isTaskDone, creationDate: creationDate, modifiedDate: modifiedDate)
        print(item)
        return item
    }
}
