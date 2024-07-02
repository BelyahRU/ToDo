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
    
    let items: [TodoItem]
    
    func makeUIViewController(context: Context) -> CalendarViewController {
        var vc = CalendarViewController()
        var viewModel = CalendarViewModel(toDosModel: items)
        vc.setupViewModel(viewModel: viewModel)
        vc.navigationItem.title = "Мои дела"
        return vc
    }

    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
        // Обновление данных во ViewController если требуется
    }
    
}
