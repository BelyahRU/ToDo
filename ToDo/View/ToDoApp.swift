//
//  ToDoApp.swift
//  ToDo
//
//  Created by Александр Андреев on 17.06.2024.
//

import SwiftUI
import CocoaLumberjackSwift

@main
struct ToDoApp: App {
    
    init() {
        setupLogger()
        
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    Task {
                        do {
                            try await setupNetworking()
                        } catch {
                            DDLogError("Failed to setup networking: \(error)")
                        }
                    }
                }
        }
    }
    
    func setupLogger() {
        let fileLog = DDFileLogger()
        fileLog.rollingFrequency = TimeInterval(60 * 60 * 24)
        fileLog.logFileManager.maximumNumberOfLogFiles = 8
        DDLog.add(fileLog)
        DDLog.add(DDOSLogger.sharedInstance)
    }
    func setupNetworking() async throws {

        var ne = NetworkService()
//        var ne = NetworkService(session: session)
        let data = try await ne.fetchAllTodos()
        print(data)

    }
}
class URLSessionDelegateHandler: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Игнорируем ошибки сертификата
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
