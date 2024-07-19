//
//  NetworkService.swift
//  ToDo
//
//  Created by Александр Андреев on 19.07.2024.
//

import Foundation
protocol NetworkService {
    func createItem(item: TodoItem, revision: Int) async throws -> ToDoItemResponse
    func fetchAllTodos() async throws -> ToDoListResponse
//    func fetchItem(id: String) async throws -> ToDoItemResponse
//    func updateAllTodos(list: [TodoItem], revision: Int) async throws -> ToDoListResponse
//    func updateItem(id: String, item: TodoItem, revision: Int) async throws -> ToDoItemResponse
//    func deleteItem(id: String, revision: Int) async throws -> ToDoItemResponse
}
