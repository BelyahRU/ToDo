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
        todoItem = TodoItem(id: "1", text: "покрасить забор", importance: Importance.ordinary, deadline: Date(), isTaskDone: true, creationDate: Date(), modifiedDate: nil)
        
    }

    override func tearDownWithError() throws {
        todoItem = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
