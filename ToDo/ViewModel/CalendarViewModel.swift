//
//  CalendarViewModel.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import UIKit

class CalendarViewModel: ObservableObject {
    
    @Published var toDosModel: [TodoItem] = [] {
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
    
    public var dict: [String: [TodoItem]] = [:] // ключи - sections, значения - rows
    
    public private(set) var keysArray: [String] = []
    
    private func setupKeys() {
        keysArray = []
        var deadlines = toDosModel.filter({ $0.deadline != nil }).map { $0.deadline! }
        deadlines = deadlines.sorted { item1, item2 in
            return item1 < item2
        }
        
        for deadline in deadlines where !keysArray.contains(deadline.getDayMonthFormatted()) {
            keysArray.append(deadline.getDayMonthFormatted())
        }
        keysArray.append("Другое")
    }
    
    private func setupDict() {
        var tempDict: [String: [TodoItem]] = [:]
        
        for item in toDosModel {
            if let deadline = item.deadline?.getDayMonthFormatted() {
                if tempDict[deadline] == nil {
                    tempDict[deadline] = []
                }
                tempDict[deadline]?.append(item)
            } else {
                if tempDict["Другое"] == nil {
                    tempDict["Другое"] = []
                }
                tempDict["Другое"]?.append(item)
            }
        }
        self.dict = tempDict
    }
    
    public func updateValue(by id: String, item: TodoItem) {
        print(keysArray)
        guard let index = toDosModel.firstIndex(where: { $0.id == item.id }) else {
            print("Updating error. Index not found")
            return
        }
        toDosModel.remove(at: index)
        toDosModel.append(item)
        setupDict()
        setupKeys()
    }
}
