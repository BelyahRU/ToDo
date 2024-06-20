//
//  FileCacheTest.swift
//  ToDoTests
//
//  Created by Александр Андреев on 21.06.2024.
//

import XCTest

final class FileCacheTest: XCTestCase {
    
    var fileCache: FileCache!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        fileCache = FileCache()
    }

    override func tearDownWithError() throws {
        fileCache = nil
        try super.tearDownWithError()
    }
    
    func testAddNewTask() {
        let todo = TodoItem(id: "1", text: "тут должен быть текст", importance: Importance.ordinary, deadline: nil, isTaskDone: true, creationDate: Date(), modifiedDate: nil)
        
        fileCache.add(new: todo)
        
        XCTAssertEqual(fileCache.toDos.count, 1)
        XCTAssertEqual(fileCache.toDos.first?.id, "1")
    }
    
    func testAddDuplicateTask() {
        let todo = TodoItem(id: "1", text: "тут должен быть текст", importance: Importance.ordinary, deadline: nil, isTaskDone: true, creationDate: Date(), modifiedDate: nil)
        
        fileCache.add(new: todo)
        fileCache.add(new: todo)
        
        XCTAssertEqual(fileCache.toDos.count, 1)
    }

    func testRemoveTask() {
        let todo = TodoItem(id: "1", text: "тут должен быть текст", importance: Importance.ordinary, deadline: nil, isTaskDone: true, creationDate: Date(), modifiedDate: nil)
        
        fileCache.add(new: todo)
        fileCache.removeTask(by: "1")
        
        XCTAssertEqual(fileCache.toDos.count, 0)
    }
    
    func testRemoveUnexistTask() {
        let todo = TodoItem(id: "1", text: "тут должен быть текст", importance: Importance.ordinary, deadline: nil, isTaskDone: true, creationDate: Date(), modifiedDate: nil)
        
        fileCache.add(new: todo)
        fileCache.removeTask(by: "5")
        
        XCTAssertEqual(fileCache.toDos.count, 1)
    }
    
    
    func testSaveInFile() {
        let todo = TodoItem(id: "1", text: "тут должен быть текст", importance: Importance.ordinary, deadline: nil, isTaskDone: true, creationDate: Date(), modifiedDate: nil)
        
        fileCache.add(new: todo)
        let fileName = "228.txt"
        fileCache.saveInFile(fileName: fileName)
        
        //проверяем, создался ли файл
        let url = FileManager.default.getUrl(from: fileName)
        XCTAssertNotNil(url)
        
        //очистка
        if let url = url {
            try? FileManager.default.removeItem(at: url)
        }
    }
    
    func testUploadFromFile() {
        let todo = TodoItem(id: "1", text: "тут должен быть текст", importance: Importance.ordinary, deadline: nil, isTaskDone: true, creationDate: Date(), modifiedDate: nil)
        fileCache.add(new: todo)
        
        let fileName = "testFile.json"
        fileCache.saveInFile(fileName: fileName)
        
        let newFileCache = FileCache()
        let uploadedToDos = newFileCache.uploadFromFile(fileName: fileName)
        
        XCTAssertEqual(uploadedToDos.count, 1)
        XCTAssertEqual(uploadedToDos.first?.id, "1")
        
        // очистка
        let url = FileManager.default.getUrl(from: fileName)
        if let url = url {
            try? FileManager.default.removeItem(at: url)
        }
    }

//    func testSaveInUnexistFile() {
//        let todo = TodoItem(id: "1", text: "тут должен быть текст", importance: Importance.ordinary, deadline: nil, isTaskDone: true, creationDate: Date(), modifiedDate: nil)
//
//        fileCache.add(new: todo)
//        let fileName = "228.txtttkjkjnnkjnonoinoino"
//        fileCache.saveInFile(fileName: fileName)
//
//        //проверяем, создался ли файл
//        let url = FileManager.default.getUrl(from: fileName)
//        XCTAssertNil(url)
//
//        //очистка
//
//    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
