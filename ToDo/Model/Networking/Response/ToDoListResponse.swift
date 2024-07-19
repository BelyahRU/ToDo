//
//  ToDoListResponse.swift
//  ToDo
//
//  Created by Александр Андреев on 19.07.2024.
//

import Foundation
import FileCachePackage

struct ToDoListResponse: JSONParsable {
    
    let status: String
    let result: [TodoItem]
    let revision: Int
    
    enum CodingKeys {
        static let status = "status"
        static let result = "list"
        static let revision = "revision"
    }
    
    var json: [String: Any] {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.status] = status
        dictionary[CodingKeys.revision] = status
        dictionary[CodingKeys.result] = result
        return dictionary
    }
    
    static func parse(json: [String: Any]) -> ToDoListResponse? {
        guard let status = json[CodingKeys.status] as? String,
              let result = json[CodingKeys.result] as? [[String: Any]],
              let revision = json[CodingKeys.revision] as? Int else {
            return nil
        }
        let resultList = result.compactMap { TodoItem.parse(json: $0) }
        return ToDoListResponse(status: status, result: resultList, revision: revision)
    }
}
