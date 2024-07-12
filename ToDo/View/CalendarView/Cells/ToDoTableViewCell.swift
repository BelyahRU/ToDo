//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    static let reuseId = "ToDoTableViewCell"
    
    var noteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 3
        return label
    }()
    
    var blackLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()
    
    var categoryCircle: UIView = {
        let view = UIView()
        let diameter: CGFloat = 10
        view.backgroundColor = .clear
        view.layer.cornerRadius = diameter / 2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 2
        view.isHidden = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setupColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
    
        contentView.addSubview(noteLabel)
        contentView.addSubview(blackLine)
        contentView.addSubview(categoryCircle)

        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        blackLine.translatesAutoresizingMaskIntoConstraints = false
        categoryCircle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            noteLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
  
            blackLine.centerYAnchor.constraint(equalTo: noteLabel.centerYAnchor, constant: 2),
            blackLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            blackLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            blackLine.heightAnchor.constraint(equalToConstant: 1),
            
            categoryCircle.widthAnchor.constraint(equalToConstant: 10),
            categoryCircle.heightAnchor.constraint(equalToConstant: 10),
            categoryCircle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            categoryCircle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }
    
}

extension ToDoTableViewCell {
    public func setupCell(text: String, isDone: Bool, category: Category) {
        if category.categoryName == "Другое" {
            categoryCircle.isHidden = true
        } else {
            categoryCircle.backgroundColor = UIColor(category.categoryColor)
            if isDone {
                categoryCircle.isHidden = true
            } else {
                categoryCircle.isHidden = false
            }
        }
        if isDone {
            noteLabel.text = text
            self.setupColorsIsDone()
            blackLine.isHidden = false
        } else {
            noteLabel.text = text
            self.setupColors()
            blackLine.isHidden = true
        }
 
    }
    
    private func setupColors() {
        if self.traitCollection.userInterfaceStyle == .dark {
            noteLabel.textColor = Resources.UIKitColors.foregroundColorDark
        } else {
            noteLabel.textColor = .black
        }
    }
    
    private func setupColorsIsDone() {
        if self.traitCollection.userInterfaceStyle == .dark {
            noteLabel.textColor = Resources.UIKitColors.foregroundColorIsDoneDark
        } else {
            noteLabel.textColor = .black.withAlphaComponent(0.4)
        }
    }
}
