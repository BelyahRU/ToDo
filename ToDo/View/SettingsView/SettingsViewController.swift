//
//  SettingsViewController.swift
//  ToDo
//
//  Created by Александр Андреев on 04.07.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let addLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите название "
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    private func configure() {
        
    }

}
