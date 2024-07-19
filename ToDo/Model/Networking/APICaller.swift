//
//  APICaller.swift
//  ToDo
//
//  Created by Александр Андреев on 17.07.2024.
//

import Foundation
struct APICaller {
    
    private let baseURL = URL(string: "https://hive.mrdekk.ru/todo")!
    private let token = "Silmarien"
    private let pathComponent = "list"
    
    private var url: URL {
        let url = self.baseURL.appendingPathComponent(self.pathComponent)
        return url
    }
    
    public func request() throws -> URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
