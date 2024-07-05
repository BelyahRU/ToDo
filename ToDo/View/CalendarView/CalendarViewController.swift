//
//  CalendarViewController.swift
//  ToDo
//
//  Created by Александр Андреев on 02.07.2024.
//

import Foundation
import UIKit
import SwiftUI

class CalendarViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var tableView: UITableView!
    var tableVC: UITableViewController!
    var layout: UICollectionViewFlowLayout!
    var viewModel: CalendarViewModel!
    var customNavigationBar: CustomNavigationBar!
    var mainViewModel: MainViewModel!
    
    var onItemsChanged: (([TodoItem]) -> Void)?
    
    var topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()
    
    var bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.6)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public func updateUI() {
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    public func setupViewModel(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    
    private func configure() {
        setupCustomNavigationBar()
        setupCollectionView()
        setupCollectionViewConstratints()
        setupTableView()
        setupTableViewConstraints()
        setupView()
    }
    
    private func setupView() {
        if self.traitCollection.userInterfaceStyle == .dark {
            
            view.backgroundColor = Resources.uikitColors.backgroundColorDark
            tableView.backgroundColor = Resources.uikitColors.backgroundColorDark
        } else {
            view.backgroundColor = Resources.uikitColors.backGroundColor
            tableView.backgroundColor = Resources.uikitColors.backGroundColor
        }
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
    
}
//MARK: Action
extension CalendarViewController {
    @objc func backPressed() {
        onItemsChanged?(viewModel.toDosModel)
        self.navigationController?.popViewController(animated: true)
    }
}




