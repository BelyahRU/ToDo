//
//  CalendarVC + TableView.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import UIKit
import SwiftUI

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseId)
        tableView.sectionHeaderTopPadding = 0
    }
    
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: bottomBorderView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //сролл коллекшн вью при скролле тейбл вью
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //(196.5, 439.5) - позиция scrollView у tableView
        if viewModel.dict.count > 1 {
            if scrollView.layer.position.y > 100 {
                if let section = sectionForTopCell() {
                    collectionView.selectItem(at: IndexPath(row: section, section: 0), animated: false, scrollPosition: .left)
                }
            }
        }
    }
    
    //выделенная ячейка
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let deadline = viewModel.keysArray[indexPath.section]
        let currentTodoItem = viewModel.dict[deadline]![indexPath.row]
        
        let todoItemBinding = Binding<TodoItem?>(get: {
                return currentTodoItem
            }, set: { newValue in
                guard let newValue = newValue else { return }
                self.mainViewModel.updateTodoItem(newValue) //обновляем значение
                self.tableView.reloadData()
                self.collectionView.reloadData()
            })
        
        let swiftUIView = ToDoModalView(todoItem: todoItemBinding, currentFramework: .UIkit)
            .environmentObject(mainViewModel)
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        self.present(hostingController, animated: true, completion: nil)
    }


    //свайп влево
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title:  "Выполнено", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let deadline = self.viewModel.keysArray[indexPath.section]
            
            var item = self.viewModel.dict[deadline]![indexPath.row]
            item.isTaskDone = true
            self.mainViewModel.updateTodoItem(item)
            
            self.viewModel.dict[deadline]![indexPath.row].isTaskDone = true
            tableView.reloadData()
            success(true)
        })
        doneAction.backgroundColor = .green
        
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
    
    //свайп вправо
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title:  "Не выполнено", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let deadline = self.viewModel.keysArray[indexPath.section]
            
            var item = self.viewModel.dict[deadline]![indexPath.row]
            item.isTaskDone = false
            self.mainViewModel.updateTodoItem(item)
            self.viewModel.dict[deadline]![indexPath.row].isTaskDone = false
            
            tableView.reloadData()
            success(true)
        })
        doneAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
    
    //получаем верхнюю секцию
    func sectionForTopCell() -> Int? {
        if let topIndexPath = tableView.indexPathsForVisibleRows?.first {
            return topIndexPath.section
        }
        return nil
    }
    
    
    //высота хедера в секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    //высота каждой ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    //тайтлы для секцмм
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.keysArray[section]
    }
    
    
    //количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.keysArray.count
    }
    
    //количество rows в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let deadline = viewModel.keysArray[section]
        return viewModel.dict[deadline]?.count ?? 0
    }
    
    //создание ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseId, for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        
        let deadline = viewModel.keysArray[indexPath.section] 
        guard let item = viewModel.dict[deadline]?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setupCell(text: item.text, isDone: item.isTaskDone, category: item.category)
        return cell
    }
}
