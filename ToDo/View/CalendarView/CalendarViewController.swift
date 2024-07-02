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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.addTopBorderWithColor(color: Resources.uikitColors.cellBorderColor.withAlphaComponent(0.2), width: 1)
        collectionView.addBottomBorderWithColor(color: Resources.uikitColors.cellBorderColor.withAlphaComponent(0.6), width: 2)
    }
    
    public func setupViewModel(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    
    private func configure() {
        setupView()
        setupCollectionView()
//        tableVC = TableViewController(viewModel: viewModel)
        setupTableView()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.barTintColor = UIColor.green
        self.navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = Resources.uikitColors.backGroundColor
    }
    
}




