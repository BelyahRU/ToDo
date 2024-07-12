//
//  RequestProcessor .swift
//  ToDo
//
//  Created by Александр Андреев on 10.07.2024.
//

import Foundation
enum RequestProcessor {
    static func makeUrl() throws -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "mybookstore.ru"
        components.path = "/api/books"
        components.queryItems = [
            URLQueryItem(name: "order", value: "asc"),
            URLQueryItem(name: "genre", value: "all")
        ]
        guard let url = components.url else {
            throw RequestProcessorError.wrongUrl(components) }
        return url
    }
    
    static func performMyAwesomeRequest(
        urlSession: URLSession = .shared,
        url: URL) async throws -> (Data, URLResponse) {
            let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
            return try await urlSession.data(for: request)
    }
}
            
enum RequestProcessorError: Error {
    case wrongUrl(URLComponents)
}
