//
//  NetworkService.swift
//  ToDo
//
//  Created by Александр Андреев on 17.07.2024.
//

import Foundation
import FileCachePackage
class DefaultNetworkService: NetworkService {
    
    enum NetworkErrors: Error {
        case unexpextedResponse(URLResponse)
        case failedResponse(HTTPURLResponse)
        case parsingError
        case unownedError
        case jsonObjectError
    }
    
    private let session: URLSession
    private let apiCaller = APICaller()
    
    private static let httpStatusCodeSuccess = 200..<300
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
}

// MARK: GET
extension DefaultNetworkService {
    func fetchAllTodos() async throws -> ToDoListResponse {
        let request = try apiCaller.request()
        return try await performRequest(request: request)
    }
    
    func fetchItem(id: String, revision: Int) async throws -> ToDoItemResponse {
        let request = try await apiCaller.fetchTodoItem(id: id, revision: revision)
        return try await performRequest(request: request)
    }
}

// MARK: POST
extension DefaultNetworkService {
    func createItem(item: TodoItem, revision: Int) async throws -> ToDoItemResponse {
        let itemResponse = ToDoItemResponse(status: "ok", result: item, revision: revision)
        let request = try await apiCaller.createTodoItem(itemResponse: itemResponse, revision: revision)
        return try await performRequest(request: request)
    }
}

// MARK: PUT
extension DefaultNetworkService {
    func updateAllTodos(list: [TodoItem], revision: Int) async throws -> ToDoListResponse {
        let listResponse = ToDoListResponse(status: "ok", result: list, revision: revision)
        let request = try await apiCaller.updateAllToDos(list: listResponse, revision: revision)
        return try await performRequest(request: request)
    }
    
    func updateItem(id: String, item: TodoItem, revision: Int) async throws -> ToDoItemResponse {
        let itemResponse = ToDoItemResponse(status: "ok", result: item, revision: revision)
        let request = try await apiCaller.updateItem(id: id, item: itemResponse, revision: revision)
        return try await performRequest(request: request)
    }
}

// MARK: DELETE
extension DefaultNetworkService {
    func deleteItem(id: String, revision: Int) async throws -> ToDoItemResponse {
        let request = try await apiCaller.deleteItem(id: id, revision: revision)
        return try await performRequest(request: request)
    }
}

// MARK: REQUEST
extension DefaultNetworkService {
    private func performRequest<T: JSONParsable>(request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkErrors.unexpextedResponse(response)
            }
            guard DefaultNetworkService.httpStatusCodeSuccess.contains(response.statusCode) else {
                throw NetworkErrors.failedResponse(response)
            }

            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                throw NetworkErrors.jsonObjectError
            }
            
            guard let requestObject = T.parse(json: json) else {
                print("Parsing error with JSON: \(json)")
                throw NetworkErrors.parsingError
            }
            return requestObject
        } catch {
            throw error
        }
    }
}
