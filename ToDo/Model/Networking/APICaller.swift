//
//  APICaller.swift
//  ToDo
//
//  Created by Александр Андреев on 17.07.2024.
//

import Foundation
import CocoaLumberjackSwift

struct APICaller {
    private let baseURL: URL
    private let token: String
    private let pathComponent = "list"
    
    init(baseURL: URL = URL(string: "https://hive.mrdekk.ru/todo")!,
         token: String = "") {
        self.baseURL = baseURL
        self.token = token
        DDLogInfo("APICaller initialized with baseURL: \(baseURL) and token: \(token)")
    }
    
    private var url: URL {
        return baseURL.appendingPathComponent(pathComponent)
    }
    
    private func createRequest(method: String,
                               url: URL,
                               httpBody: Data? = nil,
                               headers: [String: String] = [:]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.allHTTPHeaderFields = headers
        request.httpBody = httpBody
        DDLogInfo("Creating request with method: \(method), url: \(url), headers: \(headers)")
        if let body = httpBody {
            DDLogDebug("Request body: \(String(data: body, encoding: .utf8) ?? "N/A")")
        }
        return request
    }
    
    public func request() throws -> URLRequest {
        DDLogInfo("Creating GET request for url: \(url)")
        return createRequest(method: "GET", url: url)
    }
    
    public func createTodoItem(itemResponse: ToDoItemResponse, revision: Int) async throws -> URLRequest {
        let jsonData = try JSONSerialization.data(withJSONObject: itemResponse.json)
        let headers = ["X-Last-Known-Revision": "\(revision)"]
        DDLogInfo("Creating POST request to create TodoItem with revision: \(revision)")
        return createRequest(method: "POST", url: url, httpBody: jsonData, headers: headers)
    }
    
    public func fetchTodoItem(id: String, revision: Int) async throws -> URLRequest {
        let fetchURL = url.appendingPathComponent(id)
        DDLogInfo("Creating GET request to fetch TodoItem with id: \(id) and revision: \(revision)")
        return createRequest(method: "GET", url: fetchURL)
    }
    
    public func updateAllToDos(list: ToDoListResponse, revision: Int) async throws -> URLRequest {
        let jsonData = try JSONSerialization.data(withJSONObject: list.json)
        let headers = ["X-Last-Known-Revision": "\(revision)"]
        DDLogInfo("Creating PATCH request to update all TodoItems with revision: \(revision)")
        return createRequest(method: "PATCH", url: url, httpBody: jsonData, headers: headers)
    }
    
    public func updateItem(id: String, item: ToDoItemResponse, revision: Int) async throws -> URLRequest {
        let fetchURL = url.appendingPathComponent(id)
        let jsonData = try JSONSerialization.data(withJSONObject: item.json)
        let headers = ["X-Last-Known-Revision": "\(revision)"]
        DDLogInfo("Creating PUT request to update TodoItem with id: \(id) and revision: \(revision)")
        return createRequest(method: "PUT", url: fetchURL, httpBody: jsonData, headers: headers)
    }
    
    public func deleteItem(id: String, revision: Int) async throws -> URLRequest {
        let fetchURL = url.appendingPathComponent(id)
        let headers = ["X-Last-Known-Revision": "\(revision)"]
        DDLogInfo("Creating DELETE request to delete TodoItem with id: \(id) and revision: \(revision)")
        return createRequest(method: "DELETE", url: fetchURL, headers: headers)
    }
}
