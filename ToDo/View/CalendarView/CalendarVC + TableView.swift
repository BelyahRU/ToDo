//
//  CalendarVC + TableView.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import UIKit

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    
    func setupTableView() {
        tableView = UITableView()
        tableView.backgroundColor = Resources.uikitColors.backGroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseId)
        tableView.sectionHeaderTopPadding = 0
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //(196.5, 424.5) - позиция scrollView у tableView
        if scrollView.layer.position.x == 196.5 && scrollView.layer.position.y == 424.5 {
            if let section = sectionForTopCell() {
                collectionView.selectItem(at: IndexPath(row: section, section: 0), animated: false, scrollPosition: .left)
            }
        }
    }
    
        
    func sectionForTopCell() -> Int? {
        if let topIndexPath = tableView.indexPathsForVisibleRows?.first {
            return topIndexPath.section
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.keysArray[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.keysArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let deadline = viewModel.keysArray[section]
        return viewModel.dict[deadline]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseId, for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        
        let deadline = viewModel.keysArray[indexPath.section]
        cell.setupCell(text: viewModel.dict[deadline]![indexPath.row].text)
        return cell
    }
}
