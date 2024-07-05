//
//  ToDoCollectionViewCell.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import UIKit
class ToDoCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CollectionViewCell"
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = Resources.uikitColors.cellBorderColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            // Изменяем стиль ячейки при выборе
            if isSelected {
                backView.backgroundColor = Resources.uikitColors.cellBackgoundColor
                backView.makeBorders(width: 2)
                backView.makeRadius(radius: 15)
                backView.makeBordersColor(color: Resources.uikitColors.cellBorderCGColor)
            } else {
                backView.makeBorders(width: 0)
                backView.backgroundColor = .clear
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(backView)
        backView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textLabel.topAnchor.constraint(equalTo: backView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            textLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5)

        ])
    }
}

extension ToDoCollectionViewCell {
    public func setupCell(text: String) {
        // Разбиваем текст на слова и соединяем их с символом новой строки
        let words = text.split(separator: " ")
        let newText = words.joined(separator: "\n\n")
        self.textLabel.text = newText
    }
}

