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
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(noteLabel)

        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            noteLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            
        ])
    }
    
}

extension ToDoTableViewCell {
    public func setupCell(text: String) {
        noteLabel.text = text
    }
}
