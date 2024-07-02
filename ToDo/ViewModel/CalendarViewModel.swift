//
//  CalendarViewModel.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation



class CalendarViewModel {
    
    var toDosModel: [TodoItem] = [] {
        willSet {
            setupDict()
            setupKeys()
        }
    }
    
    init(toDosModel: [TodoItem]) {
        self.toDosModel = toDosModel
        setupDict()
        setupKeys()
    }
    
    public var dict: [String: [TodoItem]] = [:]
    
    public var keysArray: [String] = []
    
    public func setupKeys() {
        keysArray = []
        var deadlines = toDosModel.filter({$0.deadline != nil}).map { $0.deadline! }
        deadlines = deadlines.sorted { item1, item2 in
            return item1 < item2
        }
        
        for i in deadlines {
            if !keysArray.contains(i.getDayMonthFormatted()) {
                keysArray.append(i.getDayMonthFormatted())
            }
        }
        keysArray.append("Другие")
    }
    
    public func setupDict() {
        var tempDict: [String: [TodoItem]] = [:]
        
        for item in toDosModel {
            if let deadline = item.deadline?.getDayMonthFormatted() {
                if tempDict[deadline] == nil {
                    tempDict[deadline] = []
                }
                tempDict[deadline]?.append(item)
            } else {
                if tempDict["Другие"] == nil {
                    tempDict["Другие"] = []
                }
                tempDict["Другие"]?.append(item)
            }
        }
        self.dict = tempDict
    }
}
