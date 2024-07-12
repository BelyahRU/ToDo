//
//  MainViewModel.swift
//  ToDo
//
//  Created by Александр Андреев on 24.06.2024.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published private(set) var model = ToDoItemModel()
    
    @Published var contentFilter: ContentFilter = .allItems {
        didSet {
            filterTodos()
        }
    }
    @Published var countItemsAreDone = 0
    
    @Published var todosArray: [TodoItem] = [] {
        didSet {
            countingAreDone()
        }
    }

    init() {
        filterTodos()
        countingAreDone()
    }
    
    private func countingAreDone() {
        countItemsAreDone = model.toDos.filter({ $0.isTaskDone == true }).count
    }
    
    private func filterTodos() {
        if contentFilter == .allItems {
            todosArray = model.toDos
        } else {
            todosArray = model.toDos.filter { !$0.isTaskDone }
        }
    }
    
    private func updateData() {
        filterTodos()
    }
    
    public func addToDo(new item: TodoItem?) {
        guard let item = item else { return }
        model.add(new: item)
        updateData()
    }
    
    public func removeItem(item: TodoItem?) {
        guard let item = item else { return }
        model.removeTask(by: item.id)
        updateData()
        print("успешно удалено")
    }
    
    public func updateTodoItem(_ item: TodoItem) {
        // Обновление элемента в fileCacheModel
        model.updateTask(item)
        
        // Обновление элемента в todosArray
        if let index = todosArray.firstIndex(where: { $0.id == item.id }) {
            todosArray[index] = item
        }
        
        // Перефильтровка данных
        updateData()
    }
}
