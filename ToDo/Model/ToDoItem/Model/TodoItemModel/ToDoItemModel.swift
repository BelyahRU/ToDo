//
//  ToDoItemModel.swift
//  ToDo
//
//  Created by Александр Андреев on 10.07.2024.
//

import Foundation
import FileCachePackage
import CocoaLumberjackSwift // логирование

class ToDoItemModel {
    
    var toDos: [TodoItem] = []
    
    init(toDos: [TodoItem] = ToDoItems.getToDosArray()) {
        self.toDos = toDos
    }
    
    public let fileCache = FileCache<TodoItem>()
    
    func add(new task: TodoItem) {
        //проверка на дублирование
        if toDos.first(where: { $0.id == task.id }) != nil {
            print("FileCache Error. Task added before")
            DDLogError("task with the same id was added before")
        } else{
            toDos.append(task)
            DDLogInfo("new task added to ToDoItemModel")
        }
        
    }
    
    func removeTask(by id: String) {
        toDos.removeAll(where: { $0.id == id })
        DDLogInfo("task removed from ToDoItemModel")
    }
    
    func updateTask(_ item: TodoItem) {
        if let index = toDos.firstIndex(where: { $0.id == item.id }) {
            toDos[index] = item
            DDLogInfo("task id:\(item.id) was update")
        } else {
            DDLogWarn("task id:\(item.id) not updated because not found")
        }
    }
}

