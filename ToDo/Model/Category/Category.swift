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
    
    init?(hex: String) {
        guard hex.hasPrefix("#") else { return nil }
        let hexColor = String(hex.dropFirst())
        guard hexColor.count == 8 else { return nil }

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else { return nil }

        self.red = Double((hexNumber & 0xff000000) >> 24) / 255
        self.green = Double((hexNumber & 0x00ff0000) >> 16) / 255
        self.blue = Double((hexNumber & 0x0000ff00) >> 8) / 255
        self.alpha = Double(hexNumber & 0x000000ff) / 255
    }

    var hex: String {
        return String(format: "#%02lX%02lX%02lX%02lX",
                      lround(red * 255),
                      lround(green * 255),
                      lround(blue * 255),
                      lround(alpha * 255))
    }

    var color: Color {
        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct Category: Equatable, Hashable, Codable {
    var categoryName: String
    var categoryColor: CodableColor
    
    init(categoryName: String, categoryColor: CodableColor) {
        self.categoryName = categoryName
        self.categoryColor = categoryColor
    }
    
    init(categoryColor: String) {
        self.categoryName = categoryColor
        self.categoryColor = CodableColor(hex: categoryColor) ?? .init(color: .clear)
    }
    
    var json: [String: Any] {
        return [
            "categoryName": categoryName,
            "categoryColor": categoryColor.hex // Преобразование categoryColor в HEX строку
        ]
    }
    
    static func parse(json: [String: Any]) -> Category? {
            guard let categoryName = json["categoryName"] as? String,
                  let hexColor = json["categoryColor"] as? String,
                  let categoryColor = CodableColor(hex: hexColor) else {
                return nil
            }
            
            return Category(categoryName: categoryName, categoryColor: categoryColor)
        }
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
