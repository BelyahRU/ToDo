//
//  MainViewModel.swift
//  ToDo
//
//  Created by Александр Андреев on 24.06.2024.
//

import Foundation
class MainViewModel: ObservableObject {
    //@Published использует внутри класса, который реализует протокол ObservableObject
    //Это позволяет автоматически уведомлять всех подписчиков об изменениях в данных.
    //Всякий раз, когда изменяется этот массив, все подписчики будут уведомлены об этом изменении.
    @Published var todosArray: [TodoItem] = [
            TodoItem(
                text: "Купить продукты",
                importance: .important,
                deadline: Calendar.current.date(byAdding: .day, value: 1, to: Date()),
                isTaskDone: false,
                creationDate: Date(),
                modifiedDate: nil
            ),
            TodoItem(
                text: "Завершить проект",
                importance: .ordinary,
                deadline: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
                isTaskDone: false,
                creationDate: Date(),
                modifiedDate: nil
            ),
            TodoItem(
                text: "Позвонить маме",
                importance: .important,
                deadline: nil,
                isTaskDone: false,
                creationDate: Date(),
                modifiedDate: nil
            ),
            TodoItem(
                text: "Забрать посылку",
                importance: .unimportant,
                deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
                isTaskDone: true,
                creationDate: Date(),
                modifiedDate: Date()
            ),
            TodoItem(
                text: "Прочитать книгу",
                importance: .ordinary,
                deadline: nil,
                isTaskDone: false,
                creationDate: Date(),
                modifiedDate: nil
            ),
            TodoItem(
                text: "Забрать посылку",
                importance: .unimportant,
                deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
                isTaskDone: true,
                creationDate: Date(),
                modifiedDate: Date()
            ),
            TodoItem(
                text: "Прочитать книгу",
                importance: .ordinary,
                deadline: nil,
                isTaskDone: false,
                creationDate: Date(),
                modifiedDate: nil
            ),
            TodoItem(
                text: "Забрать посылку",
                importance: .unimportant,
                deadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
                isTaskDone: true,
                creationDate: Date(),
                modifiedDate: Date()
            ),
            TodoItem(
                text: "Прочитать книгу",
                importance: .ordinary,
                deadline: nil,
                isTaskDone: false,
                creationDate: Date(),
                modifiedDate: nil
            )
        ]
    
    public func getToDosArray() -> [TodoItem] {
        todosArray
    }
    
    public func addToDo(new item: TodoItem) {
        todosArray.append(item)
    }
    
}
