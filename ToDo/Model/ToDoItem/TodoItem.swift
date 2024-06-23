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
    let isTaskDone: Bool // флаг
    let creationDate: Date
    let modifiedDate: Date?
    
    enum Importance: String {
        case unimportant = "неважная"
        case ordinary = "обычная"
        case important = "важная"
    }
    
    init(id: String,
         text: String,
         importance: Importance,
         deadline: Date?,
         isTaskDone: Bool,
         creationDate: Date,
         modifiedDate: Date?) {
        
        self.id = id
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.isTaskDone = isTaskDone
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        
    }
}
