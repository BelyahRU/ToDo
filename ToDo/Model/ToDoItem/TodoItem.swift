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
//TodoItem(
//    text: "Купить продукты",
//    importance: .important,
//    deadline: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil,
//    category: Categories.shared.getCategory(by: "Работа")
//),
//TodoItem(
//    text: "Завершить проект",
//    importance: .ordinary,
//    deadline: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Позвонить маме",
//    importance: .important,
//    deadline: nil,
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil,
//    category: Categories.shared.getCategory(by: "Работа")
//),
//TodoItem(
//    text: "Сделать дз",
//    importance: .unimportant,
//    deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
//    isTaskDone: true,
//    creationDate: Date(),
//    modifiedDate: Date()
//),
//TodoItem(
//    text: "Прочитать книгу",
//    importance: .ordinary,
//    deadline: nil,
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Купить айфон",
//    importance: .unimportant,
//    deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
//    isTaskDone: true,
//    creationDate: Date(),
//    modifiedDate: Date()
//),
//TodoItem(
//    text: "Поплавать в бассейне",
//    importance: .ordinary,
//    deadline: nil,
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Забрать посылку",
//    importance: .unimportant,
//    deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
//    isTaskDone: true,
//    creationDate: Date(),
//    modifiedDate: Date(),
//    category: Categories.shared.getCategory(by: "Учеба")
//),
//TodoItem(
//    text: "Прочитать журнал",
//    importance: .ordinary,
//    deadline: nil,
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil,
//    category: Categories.shared.getCategory(by: "Учеба")
//),
//
//TodoItem(
//    text: "Купить продукты",
//    importance: .important,
//    deadline: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil,
//    category: Categories.shared.getCategory(by: "Учеба")
//),
//TodoItem(
//    text: "Завершить проект",
//    importance: .ordinary,
//    deadline: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil,
//    category: Categories.shared.getCategory(by: "Хобби")
//),
//TodoItem(
//    text: "Позвонить маме",
//    importance: .important,
//    deadline: nil,
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Забрать посылку",
//    importance: .unimportant,
//    deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
//    isTaskDone: true,
//    creationDate: Date(),
//    modifiedDate: Date(),
//    category: Categories.shared.getCategory(by: "Другое")
//),
//TodoItem(
//    text: "Прочитать книгу",
//    importance: .ordinary,
//    deadline: nil,
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Починить велосипед",
//    importance: .important,
//    deadline: Calendar.current.date(byAdding: .day, value: 2, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Поздравить друга с днем рождения",
//    importance: .important,
//    deadline: Calendar.current.date(byAdding: .day, value: 5, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Посетить врача",
//    importance: .ordinary,
//    deadline: Calendar.current.date(byAdding: .day, value: 10, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Пойти в спортзал",
//    importance: .unimportant,
//    deadline: Calendar.current.date(byAdding: .day, value: 4, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Сходить в кино",
//    importance: .ordinary,
//    deadline: nil,
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil,
//    category: Categories.shared.getCategory(by: "Хобби")
//),
//TodoItem(
//    text: "Посетить концерт",
//    importance: .important,
//    deadline: Calendar.current.date(byAdding: .day, value: 15, to: Date()),
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//),
//TodoItem(
//    text: "Сделать уборку в доме",
//    importance: .unimportant,
//    deadline: nil,
//    isTaskDone: false,
//    creationDate: Date(),
//    modifiedDate: nil
//)
