//
//  SettingsViewController.swift
//  ToDo
//
//  Created by Александр Андреев on 04.07.2024.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    let settingsView = SettingsView()
    var currentColor: UIColor? = nil
    var currentText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    private func configure() {
        setupView()
        setupTargets()
    }
    
    private func setupView() {
        view.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func setupTargets() {
        settingsView.customNavigationBar.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        settingsView.colorButton.addTarget(self, action: #selector(colorPickerTapped), for: .touchUpInside)
        settingsView.saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
    }
    

}

extension SettingsViewController {
    @objc func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func colorPickerTapped() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.modalPresentationStyle = .popover
        colorPickerVC.modalTransitionStyle = .crossDissolve
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    @objc func savePressed() {
        self.currentText = settingsView.nameTextField.text ?? ""
        if currentText != "" && currentColor != nil{
            Categories.shared.createCategory(name: currentText, color: Color(currentColor!))
            self.settingsView.statusLabel.isHidden = false
            self.settingsView.statusLabel.text = "OK"
        } else {
            self.settingsView.statusLabel.isHidden = false
            self.settingsView.statusLabel.text = "NOT OK"
        }
    }
    
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.settingsView.colorCircle.backgroundColor = viewController.selectedColor
        self.currentColor = viewController.selectedColor
    }
    
     
}
