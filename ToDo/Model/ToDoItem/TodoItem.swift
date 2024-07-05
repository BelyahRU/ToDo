//
//  TodoItem.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import Foundation
enum Importance: String {
    case unimportant = "неважная"
    case ordinary = "обычная"
    case important = "важная"
}

struct TodoItem: Identifiable, Equatable {
    
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    var isTaskDone: Bool // флаг
    let creationDate: Date
    let modifiedDate: Date?
    
    let category: Category
    
    init(id: String = UUID().uuidString,
         text: String,
         importance: Importance,
         deadline: Date?,
         isTaskDone: Bool,
         creationDate: Date,
         modifiedDate: Date?, category: Category = Category(categoryName: "Другое", categoryColor: .clear)) {
        
        self.id = id
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.isTaskDone = isTaskDone
        self.creationDate = creationDate
        self.modifiedDate = modifiedDate
        self.category = category
        
    }
}
