//
//  TodoItem + JSON parsing.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import Foundation
extension TodoItem {
    
    
    static func parse(json: Any) -> TodoItem? {
        
        guard let data = try? JSONSerialization.data(withJSONObject: json) else {
                    return nil
                }
                
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        
        
        guard let importanceStr = dictionary["importance"] as? String else {
            print("JSON parsing error.Importance nil")
            return nil
        }
        guard let importance = Importance(rawValue: importanceStr) else {
            print("JSON parsing error. Importance not found")
            return nil
        }
        guard let text = dictionary["text"] as? String else {
            print("JSON parsing error.text nil")
            return nil
        }
        
        guard let IsTaskDone = dictionary["IsTaskDone"] as? Bool else {
            print("JSON parsing error.IsTaskDone nil")
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let creationDate = dateFormatter.date(from: (dictionary["creationDate"] as? String)!) else {
            print("JSON parsing error.creationDate nil")
            return nil
        }
        
        let id = dictionary["id"] as? String ?? nil
        let deadline = dictionary["deadline"] as? Date
        let modifiedDate = dictionary["modifiedDate"] as? Date
        
        let item = TodoItem(id: id, text: text, importance:  importance, deadline: deadline, IsTaskDone: IsTaskDone, creationDate: creationDate, modifiedDate: modifiedDate)
        print(item)
        return item
    }
}
