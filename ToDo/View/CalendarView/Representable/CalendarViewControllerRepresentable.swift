//
//  CalendarViewControllerRepresentable.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import UIKit
import SwiftUI

struct CalendarViewControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var items: [TodoItem]
    @EnvironmentObject var mainViewModel: MainViewModel
    
    func makeUIViewController(context: Context) -> CalendarViewController {
        let calendarVC = CalendarViewController()
        let viewModel = CalendarViewModel(toDosModel: items)
        calendarVC.onItemsChanged = { updatedItems in
           items = updatedItems
       }
        calendarVC.setupViewModel(viewModel: viewModel)
        calendarVC.mainViewModel = mainViewModel
        return calendarVC
    }

    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
        // Обновление данных во ViewController если требуется
        uiViewController.setupViewModel(viewModel: CalendarViewModel(toDosModel: items))
        uiViewController.updateUI()
    }
    
}