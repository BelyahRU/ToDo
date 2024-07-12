//
//  FileCacheTest.swift
//  ToDoTests
//
//  Created by Александр Андреев on 21.06.2024.
//

import XCTest

final class FileCacheTest: XCTestCase {
    
    var fileCacheModel: ToDoItemModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        fileCacheModel = ToDoItemModel()
    }

    override func tearDownWithError() throws {
        fileCacheModel = nil
        try super.tearDownWithError()
    }
    
    // тестирование на добавление новой задачи
    func testAddNewTask() {
        let todo = TodoItem(id: "1",
                            text: "тут должен быть текст", 
                            importance: Importance.ordinary,
                            deadline: nil,
                            isTaskDone: true,
                            creationDate: Date(), 
                            modifiedDate: nil)
        
        fileCacheModel.add(new: todo)
        
        XCTAssertEqual(fileCacheModel.toDos.count, 1)
        XCTAssertEqual(fileCacheModel.toDos.first?.id, "1")
    }
    
    // тестирование на добавление новой задачи с уже добавленным id
    func testAddDuplicateTask() {
        let todo = TodoItem(id: "1", 
                            text: "тут должен быть текст",
                            importance:
                                Importance.ordinary,
                            deadline: nil,
                            isTaskDone: true,
                            creationDate: Date(),
                            modifiedDate: nil)
        
        fileCacheModel.add(new: todo)
        fileCacheModel.add(new: todo)
        
        XCTAssertEqual(fileCacheModel.toDos.count, 1)
    }

    // тест на удаление задачи из filecache
    func testRemoveTask() {
        let todo = TodoItem(id: "1", 
                            text: "тут должен быть текст", 
                            importance: Importance.ordinary,
                            deadline: nil,
                            isTaskDone: true,
                            creationDate: Date(),
                            modifiedDate: nil)
        fileCacheModel.add(new: todo)
        fileCacheModel.removeTask(by: "1")
        
        XCTAssertEqual(fileCacheModel.toDos.count, 0)
    }
    
    // тест на удаление несуществующей задачи из fileCache
    func testRemoveUnexistTask() {
        let todo = TodoItem(id: "1", 
                            text: "тут должен быть текст",
                            importance: Importance.ordinary,
                            deadline: nil,
                            isTaskDone: true,
                            creationDate: Date(),
                            modifiedDate: nil)
        
        fileCacheModel.add(new: todo)
        fileCacheModel.removeTask(by: "5")
        
        XCTAssertEqual(fileCacheModel.toDos.count, 1)
    }
    
    // тест на проверку сохранения в файл
    func testSaveInFile() {
        let todo = TodoItem(id: "1", 
                            text: "тут должен быть текст",
                            importance: Importance.ordinary,
                            deadline: nil,
                            isTaskDone: true,
                            creationDate: Date(),
                            modifiedDate: nil)
        
        fileCacheModel.add(new: todo)
        let fileName = "228.txt"
        fileCacheModel.saveInFile(fileName: fileName)
        
        // проверяем, создался ли файл
        let url = FileManager.default.getUrl(from: fileName)
        XCTAssertNotNil(url)
        
        // очистка
        if let url = url {
            try? FileManager.default.removeItem(at: url)
        }
    }
    
    // тест на проверку загрузки из файла
    func testUploadFromFile() {
        let todo = TodoItem(id: "1", 
                            text: "тут должен быть текст",
                            importance: Importance.ordinary,
                            deadline: nil,
                            isTaskDone: true,
                            creationDate: Date(),
                            modifiedDate: nil)
        fileCacheModel.add(new: todo)
        
        let fileName = "testFile.json"
        fileCacheModel.saveInFile(fileName: fileName)
        
        let newfileCacheModel = ToDoItemModel()
        let uploadedToDos = newfileCacheModel.uploadFromFile(fileName: fileName)
        
        XCTAssertEqual(uploadedToDos.count, 1)
        XCTAssertEqual(uploadedToDos.first?.id, "1")
        
        // очистка
        let url = FileManager.default.getUrl(from: fileName)
        if let url = url {
            try? FileManager.default.removeItem(at: url)
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
