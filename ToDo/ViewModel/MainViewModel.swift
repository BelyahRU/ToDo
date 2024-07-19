//
//  MainViewModel.swift
//  ToDo
//
//  Created by Александр Андреев on 24.06.2024.
//

import Foundation
import Combine

@MainActor // Гарантирует, что все методы выполняются на главном потоке
class MainViewModel: ObservableObject {
    
    @Published private(set) var model = ToDoItemModel()
    
    @Published var contentFilter: ContentFilter = .allItems {
        didSet {
            Task {
                await filterTodos()
            }
        }
    }
    @Published var countItemsAreDone = 0
    
    @Published var todosArray: [TodoItem] = [] {
        didSet {
            countingAreDone()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            await initializeData()
        }
    }
    
    private func initializeData() async {
        do {
            try await model.fetchTodos()
            await updateData()
        } catch {
            print("Failed to initialize data: \(error.localizedDescription)")
        }
    }
    
    private func countingAreDone() {
        countItemsAreDone = todosArray.filter({ $0.isTaskDone }).count
    }
    
    private func filterTodos() async {
        if contentFilter == .allItems {
            todosArray = model.toDos
        } else {
            todosArray = model.toDos.filter { !$0.isTaskDone }
        }
    }
    
    private func updateData() async {
        await filterTodos()
    }
    
    public func addToDo(new item: TodoItem?) {
        guard let item = item else { return }
        Task {
            do {
                try await model.add(new: item)
                await updateData()
            } catch {
                print("Failed to add task: \(error.localizedDescription)")
            }
        }
    }
    
    public func removeItem(item: TodoItem?) {
        guard let item = item else { return }
        Task {
            do {
                try await model.removeTask(by: item.id)
                await updateData()
                print("успешно удалено")
            } catch {
                print("Failed to remove task: \(error.localizedDescription)")
            }
        }
    }
    
    public func updateTodoItem(_ item: TodoItem) {
        Task {
            do {
                try await model.updateTask(item)
                if let index = todosArray.firstIndex(where: { $0.id == item.id }) {
                    todosArray[index] = item
                }
                await updateData()
            } catch {
                print("Failed to update task: \(error.localizedDescription)")
            }
        }
    }
}
