//
//  SettingsView.swift
//  ToDo
//
//  Created by Александр Андреев on 04.07.2024.
//

import Foundation
import UIKit

class SettingsView: UIView {
    let customNavigationBar = CustomNavigationBar(title: "Добавление новой категории")
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите название категории: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.makeBorders(width: 1)
        tf.makeRadius(radius: 8)
        return tf
    }()
    
    let chooseColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите цвет"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let colorButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pickerButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let colorSV: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 10
        sv.alignment = .leading
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let choosenColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбранный цвет: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var colorCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let diameter: CGFloat = 20
        view.backgroundColor = .clear
        view.layer.cornerRadius = diameter / 2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 2
        return view
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.makeBorders(width: 1)
        button.makeRadius(radius: 13)
        button.setTitle("Сохранить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        setupSubviews()
        setupStackView()
        setupConstraints()
        setupButtonTextColor()
    }
    
    private func setupSubviews() {
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customNavigationBar)
        addSubview(chooseColorLabel)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(colorButton)
        addSubview(colorSV)
        addSubview(saveButton)
        addSubview(statusLabel)
    }
    
    private func setupButtonTextColor() {
        if self.traitCollection.userInterfaceStyle == .dark {
            
            saveButton.setTitleColor(.white, for: .normal)
        } else {
            saveButton.setTitleColor(.black, for: .normal)
        }
    }
    
    private func setupStackView() {
        colorSV.addArrangedSubview(choosenColorLabel)
        colorSV.addArrangedSubview(colorCircle)
    }

    private func setupConstraints() {
    NSLayoutConstraint.activate([
        customNavigationBar.widthAnchor.constraint(equalTo: self.widthAnchor),
        customNavigationBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        customNavigationBar.topAnchor.constraint(equalTo: self.topAnchor),
        customNavigationBar.heightAnchor.constraint(equalToConstant: 30),

        nameLabel.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 15),
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
        nameTextField.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

        chooseColorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
        chooseColorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

        colorButton.centerYAnchor.constraint(equalTo: chooseColorLabel.centerYAnchor),
        colorButton.leadingAnchor.constraint(equalTo: chooseColorLabel.trailingAnchor, constant: 16),
        colorButton.widthAnchor.constraint(equalToConstant: 30),
        colorButton.heightAnchor.constraint(equalToConstant: 30),

        colorSV.topAnchor.constraint(equalTo: chooseColorLabel.bottomAnchor, constant: 30),
        colorSV.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//        colorSV.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        colorSV.heightAnchor.constraint(equalToConstant: 20),

        colorCircle.widthAnchor.constraint(equalToConstant: 20),
        colorCircle.heightAnchor.constraint(equalToConstant: 20),

        saveButton.topAnchor.constraint(equalTo: colorSV.bottomAnchor, constant: 30),
        saveButton.widthAnchor.constraint(equalToConstant: 162),
        saveButton.heightAnchor.constraint(equalToConstant: 34),
        saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),

        statusLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 15),
        statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
    ])
    }
}


