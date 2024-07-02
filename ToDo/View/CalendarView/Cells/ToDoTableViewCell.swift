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
        return label
    }()
    
    var blackLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        return view
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
        contentView.addSubview(blackLine)

        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        blackLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            noteLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
  
            blackLine.centerYAnchor.constraint(equalTo: noteLabel.centerYAnchor, constant: 2),
            blackLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            blackLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            blackLine.heightAnchor.constraint(equalToConstant: 1)
            
        ])
    }
    
    
}

extension ToDoTableViewCell {
    public func setupCell(text: String, isDone: Bool) {
        if isDone {
            noteLabel.text = text
            noteLabel.textColor = .black.withAlphaComponent(0.4)
            blackLine.isHidden = false
        } else {
//            noteLabel.attributedText = nil
            noteLabel.text = text
            noteLabel.textColor = .black
            blackLine.isHidden = true
        }
    }
}
