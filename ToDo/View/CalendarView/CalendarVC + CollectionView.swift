//
//  CalendarVC + CollectionView.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import Foundation
import UIKit

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCollectionView() {
        layout = setupFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ToDoCollectionViewCell.self, forCellWithReuseIdentifier: ToDoCollectionViewCell.reuseId)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 90)
        ])
        collectionView.backgroundColor = .clear
        collectionView.addTopBorderWithColor(color: Resources.uikitColors.cellBorderColor.withAlphaComponent(0.2), width: 1.5)
        collectionView.addBottomBorderWithColor(color: Resources.uikitColors.cellBorderColor.withAlphaComponent(0.6), width: 2)
        print("ok")
    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = .init(width: 70, height: 70)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 6
        
        layout.minimumInteritemSpacing = 30
        
        layout.sectionInset = .init(top: 6, left: 6, bottom: 6, right: 6)
        
        layout.scrollDirection = .horizontal
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.deselectItem(at: indexPath, animated: false) as? ToDoCollectionViewCell else { return }
        cell.isSelected = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Выделяем выбранную ячейку
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        guard let cell = collectionView.cellForItem(at: indexPath) as? ToDoCollectionViewCell else { return }
        cell.isSelected = true
        
        DispatchQueue.main.async {
            //animation ?
            self.tableView.scrollToRow(at: IndexPath(item: 0, section: indexPath.row), at: .top, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.keysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Ячейки для задач с дедлайнами
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToDoCollectionViewCell.reuseId, for: indexPath) as? ToDoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(text: Array(viewModel.keysArray)[indexPath.row])
        return cell
    }
    
}


