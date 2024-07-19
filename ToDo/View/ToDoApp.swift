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

        var ne = DefaultNetworkService()
        print("111111")
        let data1 = try await ne.fetchAllTodos()
        let data2 = try await ne.createItem(item: TodoItem(text: "огромный крутой текст", importance: Importance.unimportant, deadline: Date(), isTaskDone: true, creationDate: Date(), modifiedDate: Date()), revision: data1.revision)
        print("new data")
        let data3 = try await ne.fetchAllTodos()
        print("222222")
        print(data3)
        let data4 = try await ne.deleteItem(id: "F482B244-5359-4E71-8121-34CF5F0330EF", revision: data3.revision)
        
        let data5 = try await ne.updateItem(id: "305F4E4F-72E3-4A63-9C39-D5E0963CA479", item: TodoItem(text: "Купить пиво", importance: .important, deadline: Date(), isTaskDone: true, creationDate: Date(), modifiedDate: Date()),revision: data4.revision)
        print("333333")
        print(data5)
        
        let data6 = try await ne.updateAllTodos(list: [], revision: data5.revision)
        print("444444")
        print(data6)
        
        
                                            
    }
}
