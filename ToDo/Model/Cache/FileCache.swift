//
//  FileCache.swift
//  ToDo
//
//  Created by Александр Андреев on 19.06.2024.
//

import Foundation

final class FileCache{
    private(set) var toDos: [TodoItem] = []
    
    func add(new task: TodoItem) {
        //дублирование
        if let item = toDos.first(where: { $0.id == task.id }){
            print("FileCache Error. Task added before")
        } else{
            toDos.append(task)
        }
    }
    
    func removeTask(by id: String) {
        toDos.removeAll(where: { $0.id == id })
    }
    
    func saveInFile(fileName: String) {
        let jsonDataArray = toDos.map({ $0.json })
        print(jsonDataArray)
        do {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            
            guard let documentDirectory = urls.first else {
                return
            }
            let url = documentDirectory.appendingPathComponent(fileName)
            
            let isValidJson = JSONSerialization.isValidJSONObject(jsonDataArray)
            print(isValidJson)
            if !isValidJson {
                print("JSON is not valid")
                return
            }
            let data = try JSONSerialization.data(withJSONObject: jsonDataArray)
            print(data)
            try data.write(to: url)
            print("File saved: \(url.description)")
        } catch {
            print("Error reading file: \(error.localizedDescription)")
        }
    }
    
    func uploadFromFile(fileName: String) -> [TodoItem] {
        do {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            
            guard let documentDirectory = urls.first else {
                return []
            }
            let url = documentDirectory.appendingPathComponent(fileName)
            
            let jsonData = try Data(contentsOf: url)
            let todosJson = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]] ?? []
            
            return todosJson.compactMap({ TodoItem.parse(json: $0) })
            
        } catch {
            return []
        }
    }
}
