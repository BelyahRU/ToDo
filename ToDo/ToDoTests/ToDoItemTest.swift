//
//  ToDoItemTest.swift
//  ToDoTests
//
//  Created by Александр Андреев on 21.06.2024.
//

import XCTest

final class ToDoItemTest: XCTestCase {
    
    var todoItem: TodoItem!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        todoItem = TodoItem(id: "1", 
                            text: "покрасить забор",
                            importance: Importance.important,
                            deadline: nil,
                            isTaskDone: true,
                            creationDate: Date(),
                            modifiedDate: nil)
        
    }

    override func tearDownWithError() throws {
        todoItem = nil
        try super.tearDownWithError()
    }
    
    // тестирование инициализатора
    func testTodoItemInitializator() {
        XCTAssertEqual(todoItem.id, "1")
        XCTAssertEqual(todoItem.text, "покрасить забор")
        XCTAssertEqual(todoItem.importance, Importance.important)
        XCTAssertEqual(todoItem.isTaskDone, true)
        XCTAssertEqual(todoItem.modifiedDate, nil)
        
    // проверяю созданы ли deadline и creationDate, т.к. не могу проверить значение
        XCTAssertNil(todoItem.deadline)
        XCTAssertNotNil(todoItem.creationDate)
        
    }
    
    // создание json
    func testTodoItemJson() {
        let json = todoItem.json
        XCTAssertNotNil(json)
        let isValidJson = JSONSerialization.isValidJSONObject(json)
        print(isValidJson)
//        XCTAssertTrue(isValidJson)
        XCTAssertEqual(json["id"] as? String, "1")
        XCTAssertEqual(json["text"] as? String, "покрасить забор")
        XCTAssertNotNil(json["importance"]) // т.к. если важность обычная, то она не сохраняется в json
        XCTAssertNil(json["deadline"]) // т.к. сохраняем deadline только если он задан
        XCTAssertEqual(json["isTaskDone"] as? Bool, true)
        XCTAssertNotNil(json["creationDate"])
        XCTAssertNil(json["modifiedDate"]) 
    }
    
    // парсинг не валидного json'а
    func testTodoItemParseInvalidJson() {
        let invalidJson: [String: Any] = [
            "id": "123",
            "text": "Test Task",
            // Missing 'isTaskDone' key
            "creationDate": Date().description
        ]

        let parsedItem = TodoItem.parse(json: invalidJson)
        XCTAssertNil(parsedItem)
    }
    
    // создание csv
    func testTodoItemCreatingCSV() {
        let csv = todoItem.csv
        XCTAssertNotNil(csv)
    }
    
    // парсинг валидного csv
    func testTodoItemParseValidCSV() {
        let csv = todoItem.csv
        let parsedTodoItem = TodoItem.parse(csv: csv)
        
        XCTAssertNotNil(parsedTodoItem)
        
        XCTAssertEqual(todoItem.id, parsedTodoItem!.id)
        XCTAssertEqual(todoItem.text, parsedTodoItem!.text)
        XCTAssertEqual(todoItem.importance, parsedTodoItem!.importance)
        XCTAssertEqual(todoItem.isTaskDone, parsedTodoItem!.isTaskDone)
        XCTAssertEqual(todoItem.modifiedDate?.description, parsedTodoItem!.modifiedDate?.description)
        XCTAssertEqual(todoItem.deadline?.description, parsedTodoItem!.deadline?.description)
        XCTAssertEqual(todoItem.creationDate.description, parsedTodoItem!.creationDate.description)
    }
    
    // парсинг не валидного csv
    func testTodoItemParseInvalidCSV() {
        let csv = "asdgasfodgineorignoewirg, asdg, asfg, sdfg, dfsgsd, sdfgsdef, sdfg, fdsg"
        let parsedToDoItem = TodoItem.parse(csv: csv)
        
        XCTAssertNil(parsedToDoItem)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
