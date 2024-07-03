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
        let vc = CalendarViewController()
        let viewModel = CalendarViewModel(toDosModel: items)
        vc.onItemsChanged = { updatedItems in
           items = updatedItems
       }
        vc.setupViewModel(viewModel: viewModel)
        vc.mainViewModel = mainViewModel
        return vc
    }

    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
        // Обновление данных во ViewController если требуется
        uiViewController.setupViewModel(viewModel: CalendarViewModel(toDosModel: items))
        uiViewController.updateUI()
    }
    
}
