//
//  TodoItem + JSON parsing.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import Foundation
import FileCachePackage
import UIKit

extension TodoItem: JSONParsable {
    
    enum ToDoDictionaryKeys: String, CaseIterable {
        case id = "id"
        case text = "text"
        case importance = "importance"
        case deadline = "deadline"
        case isTaskDone = "done"
        case color = "color"
        case creationDate = "created_at"
        case modifiedDate = "changed_at"
        case lastUpdatedBy = "last_updated_by"
    
    }
    var json: [String: Any] {
        var dictionary = [String: Any]()
        
        dictionary[ToDoDictionaryKeys.id.rawValue] = id
        dictionary[ToDoDictionaryKeys.text.rawValue] = text
        dictionary[ToDoDictionaryKeys.isTaskDone.rawValue] = isTaskDone
        
        dictionary[ToDoDictionaryKeys.creationDate.rawValue] = Int64(creationDate.timeIntervalSince1970)
        
        dictionary[ToDoDictionaryKeys.importance.rawValue] = importance.rawValue
        
        if let deadline = deadline {
            dictionary[ToDoDictionaryKeys.deadline.rawValue] = Int64(deadline.timeIntervalSince1970)
        }
        
        if let modifiedDate = modifiedDate {
            dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] =  Int64(modifiedDate.timeIntervalSince1970)
        } else {
            dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] =  Int64(creationDate.timeIntervalSince1970)
        }
        dictionary[ToDoDictionaryKeys.lastUpdatedBy.rawValue] =
        UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
        dictionary[ToDoDictionaryKeys.color.rawValue] = category.categoryColor.hex
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
        
        guard let creationDateInt64 = dictionary[ToDoDictionaryKeys.creationDate.rawValue] as? Int64 else {
            print("JSON parsing error.creationDate is nil")
            return nil
        }
        
        let creationDate = DateHelper.getStringFromTimestamp(creationDateInt64)
        
        guard let id = dictionary[ToDoDictionaryKeys.id.rawValue] as? String else {
            print("JSON parsing error.id is nil")
            return nil
        }
        
        let categoryColor = dictionary[ToDoDictionaryKeys.color.rawValue] as? String
        
        var category: Category?
        if categoryColor != nil {
            category = Category(categoryColor: categoryColor!)
        }
        
        let deadlineDateInt64 = dictionary[ToDoDictionaryKeys.deadline.rawValue] as? Int64
        
        var deadline: Date?
        if deadlineDateInt64 != nil {
            deadline = DateHelper.getStringFromTimestamp(deadlineDateInt64!)
        }
        
        var modifiedDate: Date?
        let modifiedDateInt64 = dictionary[ToDoDictionaryKeys.modifiedDate.rawValue] as? Int64
        
        if modifiedDateInt64 != nil {
            modifiedDate = DateHelper.getStringFromTimestamp(modifiedDateInt64!)
        }
        
        if category != nil {
            return TodoItem(id: id,
                                text: text,
                                importance: importance,
                                deadline: deadline,
                                isTaskDone: isTaskDone,
                                creationDate: creationDate,
                                modifiedDate: modifiedDate,
                                category: category!)
        } else {
            return TodoItem(id: id,
                                text: text,
                                importance: importance,
                                deadline: deadline,
                                isTaskDone: isTaskDone,
                                creationDate: creationDate,
                                modifiedDate: modifiedDate)
        }

    }
}
