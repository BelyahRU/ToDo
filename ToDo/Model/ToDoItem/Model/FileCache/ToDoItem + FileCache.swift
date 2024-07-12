//
//  ToDoItem + FileCache.swift
//  ToDo
//
//  Created by Александр Андреев on 10.07.2024.
//

import Foundation
import CocoaLumberjackSwift

// MARK: FileCache
extension ToDoItemModel {
        
    // сохранение в файл
    func saveInFile(fileName: String) {
        fileCache.saveInFile(items: self.toDos, fileName: fileName)
        DDLogInfo("data saved in file \(fileName)")
        
    }
    // загрузка данных из файла
    func uploadFromFile(fileName: String) -> [TodoItem] {
        fileCache.uploadFromFile(fileName: fileName)
    }

}
