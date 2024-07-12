//
//  TodoItem + JSON parsing.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import Foundation
import FileCachePackage

extension TodoItem: JSONParsable {
    
    enum ToDoDictionaryKeys: String, CaseIterable {
        case id
        case text
        case importance
        case deadline
        case isTaskDone
        case creationDate
        case modifiedDate
        case category
    }
    
    var json: [String: Any] {
        var dictionary = [String: Any]()
        
        dictionary[ToDoDictionaryKeys.id.rawValue] = id
        dictionary[ToDoDictionaryKeys.text.rawValue] = text
        dictionary[ToDoDictionaryKeys.isTaskDone.rawValue] = isTaskDone
        
        dictionary[ToDoDictionaryKeys.creationDate.rawValue] = DateHelper.getStringFromDate(date: creationDate)
        
        if importance != .ordinary {
            dictionary[ToDoDictionaryKeys.importance.rawValue] = importance.rawValue
        }
        
        if let deadline = deadline {
            dictionary[ToDoDictionaryKeys.deadline.rawValue] = DateHelper.getStringFromDate(date: deadline)
        }
        
        // нужно ли сохранять modifiedFate если он nil?
        if let modifiedDate = modifiedDate {
            dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] =  DateHelper.getStringFromDate(date: modifiedDate)
        }
        
        dictionary[ToDoDictionaryKeys.category.rawValue] = category
        return dictionary
    }
    
    static func parse(json: [String: Any]) -> TodoItem? {
        
        guard JSONSerialization.isValidJSONObject(json) else { return nil }
        
        guard let data = try? JSONSerialization.data(withJSONObject: json) else {
                    return nil
                }
                
        guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }

        guard let text = dictionary[ToDoDictionaryKeys.text.rawValue] as? String else {
            print("JSON parsing error.text is nil")
            return nil
        }
        
        guard let isTaskDone = dictionary[ToDoDictionaryKeys.isTaskDone.rawValue] as? Bool else {
            print("JSON parsing error.IsTaskDone is nil")
            return nil
        }
        
        let importanceStr = dictionary[ToDoDictionaryKeys.importance.rawValue] as? String ?? "обычная"
        guard let importance = Importance(rawValue: importanceStr) else {
            print("JSON parsing error.Importance not fount")
            return nil
        }
        
        guard let dateStr = dictionary[ToDoDictionaryKeys.creationDate.rawValue] as? String else {
            print("JSON parsing error.creationDate is nil")
            return nil
        }
        
        guard let creationDate = DateHelper.getDateFromString(stringDate: dateStr) else {
            print("JSON parsing error.creationDate is nil")
            return nil
        }
        
        guard let id = dictionary[ToDoDictionaryKeys.id.rawValue] as? String else {
            print("JSON parsing error.id is nil")
            return nil
        }
        
        let categoryStr = dictionary[ToDoDictionaryKeys.importance.rawValue] as? String ?? "Другое"
        let category = Categories.shared.getCategory(by: categoryStr)
        
        let deadline = DateHelper.getDateFromString(stringDate:
                        dictionary[ToDoDictionaryKeys.deadline.rawValue] as? String)
        
        let modifiedDate = DateHelper.getDateFromString(stringDate:
                        dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] as? String)
        
        let item = TodoItem(id: id,
                            text: text,
                            importance: importance,
                            deadline: deadline,
                            isTaskDone: isTaskDone,
                            creationDate: creationDate,
                            modifiedDate: modifiedDate,
                            category: category)

        return item
    }
}
