//
//  URLSession + Ext.swift
//  ToDo
//
//  Created by Александр Андреев on 12.07.2024.
//

import Foundation
import CocoaLumberjackSwift

extension URLSession {
    
    enum RequestError: Error {
        case cancelled
        case networkError(Error)
        case unknownError
    }
    
    func dataTask(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
                DDLogInfo("URLSession. Task is cancelled")
                continuation.resume(throwing: RequestError.cancelled)
                return
            }
            let task = self.dataTask(with: urlRequest) { data, response, error in
                if let data = data, let response = response {
                    DDLogInfo("URLSession. Request completed")
                    continuation.resume(returning: (data, response))
                } else if let error = error {
                    // сообщение об ошибке по-умолчанию
                    var mainError = "URLSession. Networking error: \(error.localizedDescription)"
                    // добавляем больше деталей, если ошибка - NSError
                    if case let underlyingError = error as NSError {
                        mainError += "\nDomain: \(underlyingError.domain), Code: \(underlyingError.code)"
                    }
                    let message = DDLogMessageFormat(stringLiteral: mainError)
                    DDLogError(message)
                    continuation.resume(throwing: RequestError.networkError(error))
                } else {
                    DDLogError("URLSession. Unknown error")
                    continuation.resume(throwing: RequestError.unknownError)
                }
            }

            task.resume()
        }
    }
}
