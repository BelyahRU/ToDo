//
//  SettingsViewControllerRepresentable.swift
//  ToDo
//
//  Created by Александр Андреев on 04.07.2024.
//

import Foundation
import UIKit
import SwiftUI

struct SettingsViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SettingsViewController {
        let settingsVC = SettingsViewController()
        return settingsVC
    }

    func updateUIViewController(_ uiViewController: SettingsViewController, context: Context) {
        // Обновление данных во ViewController если требуется
    }
    
}
