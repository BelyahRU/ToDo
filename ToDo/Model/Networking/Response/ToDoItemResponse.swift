//
//  ToDoItemResponse.swift
//  ToDo
//
//  Created by Александр Андреев on 19.07.2024.
//

import Foundation
import FileCachePackage
struct ToDoItemResponse: JSONParsable {
    
    let status: String
    let result: TodoItem?
    let revision: Int
    
    enum ResponseCodingKeys {
        static let status = "status"
        static let result = "element"
        static let revision = "revision"
    }
    
    var json: [String: Any] {
        var dictionary = [String: Any]()
        dictionary[ResponseCodingKeys.status] = status
        dictionary[ResponseCodingKeys.revision] = revision // Исправлено, было status
        if let result = result {
            dictionary[ResponseCodingKeys.result] = result.json // Сериализация TodoItem в словарь
        }
        return dictionary
    }
    
    static func parse(json: [String: Any]) -> ToDoItemResponse? {
        guard let status = json[ResponseCodingKeys.status] as? String,
              let result = json[ResponseCodingKeys.result] as? [String: Any],
              let revision = json[ResponseCodingKeys.revision] as? Int else {
            return nil
        }
        
        let value = TodoItem.parse(json: result)
        return ToDoItemResponse(status: status, result: value, revision: revision)
    }
}
