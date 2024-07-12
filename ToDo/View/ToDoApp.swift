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
            
        }
    }
    
    func setupLogger() {
        let fileLog = DDFileLogger()
        fileLog.rollingFrequency = TimeInterval(60 * 60 * 24)
        fileLog.logFileManager.maximumNumberOfLogFiles = 8
        DDLog.add(fileLog)
        DDLog.add(DDOSLogger.sharedInstance)
    }
}
