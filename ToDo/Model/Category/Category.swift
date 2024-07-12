//
//  Category.swift
//  ToDo
//
//  Created by Александр Андреев on 04.07.2024.
//

import Foundation
import SwiftUI

struct CodableColor: Codable, Equatable, Hashable {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double

    init(color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
        self.alpha = Double(alpha)
    }

    var color: Color {
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct Category: Equatable, Hashable, Codable {
    var categoryName: String
    var categoryColor: CodableColor
}

final class Categories {
    
    private let userDefaultsKey = "CategoriesKey"
    
    init() {
        if !UserDefaults.standard.bool(forKey: "isCategoriesInitialized") {
            let defaultCategories = [
                Category(categoryName: "Работа", categoryColor: CodableColor(color: .red)),
                Category(categoryName: "Учеба", categoryColor: CodableColor(color: .blue)),
                Category(categoryName: "Хобби", categoryColor: CodableColor(color: .green)),
                Category(categoryName: "Другое", categoryColor: CodableColor(color: .clear))
            ]
            saveCategories(defaultCategories)
            UserDefaults.standard.set(true, forKey: "isCategoriesInitialized")
        }
    }
    
    private func saveCategories(_ categories: [Category]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(categories) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadCategories() -> [Category] {
        if let savedCategories = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedCategories = try? decoder.decode([Category].self, from: savedCategories) {
                return loadedCategories
            }
        }
        return []
    }
    
    public func createCategory(name: String, color: Color) {
        var categories = loadCategories()
        let newCategory = Category(categoryName: name, categoryColor: CodableColor(color: color))
        if categories.filter({ $0 == newCategory }).count == 0 {
            categories.append(newCategory)
            saveCategories(categories)
        } else {
            print("Категория уже добавлена")
        }
    }
    
    public func getAllCategories() -> [Category] {
        return loadCategories()
    }
    
    public func removeCategory(category: Category) {
        var categories = loadCategories()
        categories = categories.filter({ $0 != category })
        saveCategories(categories)
    }
    
    public func getCategory(by name: String) -> Category {
        let categories = loadCategories()
        if let category = categories.filter({ $0.categoryName == name }).first {
            return category
        }
        print("Категория не найдена")
        return Category(categoryName: "Другое", categoryColor: CodableColor(color: .clear))
    }
}
