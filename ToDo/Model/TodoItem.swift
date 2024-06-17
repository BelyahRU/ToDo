//
//  TodoItem.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import Foundation
struct TodoItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let IsTaskDone: Bool // флаг
    let creationDate: Date
    let modifiedDate: Date?
    
    
    init(id: String?, text: String, importance: Importance, deadline: Date?, IsTaskDone: Bool, creationDate: Date, modifiedDate: Date?) {
        self.id = id ?? UUID().uuidString
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.IsTaskDone = IsTaskDone
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
    }
}
