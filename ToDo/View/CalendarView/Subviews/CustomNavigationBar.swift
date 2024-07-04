//
//  CustomNavigationBar.swift
//  ToDo
//
//  Created by Александр Андреев on 03.07.2024.
//

import Foundation
import UIKit
class CustomNavigationBar: UIView {
    
    public var navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "Мои дела"
        label.textAlignment = .center
        return label
    }()
    
    public var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    init(title: String) {
        super.init(frame: CGRect())
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupTitle()
        setupBackButton()
    }
    
    private func setupTitle() {
        addSubview(navigationTitleLabel)
        navigationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            navigationTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupBackButton() {
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .black
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
