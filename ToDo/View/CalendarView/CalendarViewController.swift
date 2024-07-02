//
//  CalendarViewController.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import UIKit

class CalendarViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var tableView: UITableView!
    var tableVC: UITableViewController!
    var layout: UICollectionViewFlowLayout!
    var viewModel: CalendarViewModel!
    var customNavigationBar: CustomNavigationBar!
    
    
    var onItemsChanged: (([TodoItem]) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.addTopBorderWithColor(color: Resources.uikitColors.cellBorderColor.withAlphaComponent(0.2), width: 1)
        collectionView.addBottomBorderWithColor(color: Resources.uikitColors.cellBorderColor.withAlphaComponent(0.6), width: 2)
    }
    
    public func updateUI() {
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    public func setupViewModel(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    
    private func configure() {
        setupView()
        setupCustomNavigationBar()
        setupCollectionView()
        setupTableView()
    }
    
    private func setupCustomNavigationBar() {
        customNavigationBar = CustomNavigationBar(title: "Мои дела")
        view.addSubview(customNavigationBar)
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            customNavigationBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        customNavigationBar.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.barTintColor = UIColor.green
        self.navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = Resources.uikitColors.backGroundColor
    }
    
}
//MARK: Action
extension CalendarViewController {
    @objc func backPressed() {
        onItemsChanged?(viewModel.toDosModel)
        self.navigationController?.popViewController(animated: true)
    }
}




