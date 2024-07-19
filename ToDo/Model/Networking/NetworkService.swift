//
//  NetworkService.swift
//  ToDo
//
//  Created by Александр Андреев on 17.07.2024.
//

import Foundation
import FileCachePackage
class NetworkService {
    
    enum NetworkErrors: Error {
        case unexpextedResponse(URLResponse)
        case failedResponse(HTTPURLResponse)
        case unownedError
    }
    
    private let session: URLSession
    private let apiCaller = APICaller()
    
    private static let httpStatusCodeSuccess = 200..<300
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchAllTodos() async throws -> Data {
        let request = try apiCaller.request()
        var todosData: Data
        do {
            let (data, response) = try await session.dataTask(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkErrors.unexpextedResponse(response)
            }
            guard NetworkService.httpStatusCodeSuccess.contains(response.statusCode) else {
                throw NetworkErrors.failedResponse(response)
            }
            todosData = data
        } catch {
            throw NetworkErrors.unownedError
        }
        
        return todosData
    }
}



