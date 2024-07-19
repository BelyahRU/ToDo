//
//  ToDoItemModel.swift
//  ToDo
//
//  Created by Александр Андреев on 10.07.2024.
//

import Foundation
import FileCachePackage
import CocoaLumberjackSwift // логирование

@MainActor // Гарантирует, что все методы выполняются на главном потоке
class ToDoItemModel {
    
    private var defaultsNetworkService: DefaultNetworkService

    private(set) var toDos: [TodoItem] = []
    private(set) var revision = 0
    private(set) var isDirty = false
    
    public let fileCache = FileCache<TodoItem>()
    
    init(networkService: DefaultNetworkService = DefaultNetworkService()) {
        self.defaultsNetworkService = networkService
        Task {
            await fetchTodos()
        }
    }
    
    func add(new task: TodoItem) async throws {
        do {
            try await defaultsNetworkService.createItem(item: task, revision: revision)
            isDirty = true
            await fetchTodos()
        } catch {
            print("Failed to add task: \(error.localizedDescription)")
            throw error
        }
    }
    
    func removeTask(by id: String) async throws {
        do {
            try await defaultsNetworkService.deleteItem(id: id, revision: revision)
            isDirty = true
            await fetchTodos()
        } catch {
            print("Failed to remove task: \(error.localizedDescription)")
            throw error
        }
    }
    
    func updateTask(_ item: TodoItem) async throws {
        do {
            try await defaultsNetworkService.updateItem(id: item.id, item: item, revision: revision)
            isDirty = true
            await fetchTodos()
        } catch {
            print("Failed to update task: \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchTodos() async {
        do {
            let response: ToDoListResponse = try await defaultsNetworkService.fetchAllTodos()
            self.revision = response.revision
            self.toDos = response.result ?? []
            self.isDirty = false
        } catch {
            print("Failed to fetch todos: \(error.localizedDescription)")
        }
    }
}
