//
//  Category.swift
//  ToDo
//
//  Created by Александр Андреев on 04.07.2024.
//

import Foundation
import SwiftUI
import SwiftUI

struct Category: Equatable, Hashable {
    var categoryName: String
    var categoryColor: Color
}

class Categories {
    
    static let shared = Categories()
    
    private init() {}
    
    private var standartCategories = [
        Category(categoryName: "Работа", categoryColor: .red),
        Category(categoryName: "Учеба", categoryColor: .blue),
        Category(categoryName: "Хобби", categoryColor: .green),
        Category(categoryName: "Другое", categoryColor: .clear)
    ]
    
    
    public func createCategory(name: String, color: Color) {
        let newCategory = Category(categoryName: name, categoryColor: color)
        if self.standartCategories.filter({$0 == newCategory}).count == 0 {
            self.standartCategories.append(newCategory)
        } else {
            print("Категория уже добавлена")
        }
    }
    
    public func getAllCategories() -> [Category] {
        standartCategories
    }
    
    public func removeCategory(category: Category) {
        self.standartCategories = self.standartCategories.filter({ $0 != category })
    }
    
    public func getCategory(by name: String) -> Category {
        if let category = self.standartCategories.filter({$0.categoryName == name}).first {
            return category
        }
        print("Категория не найдена")
        return Category(categoryName: "Другое", categoryColor: .clear)
    }
    
//    public func updateCategories() {
//
//    }
}
