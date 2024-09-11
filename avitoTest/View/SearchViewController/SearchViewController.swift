//
//  SearchViewController.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchViewModel = SearchViewModel()
    var imagesCollectionView: UICollectionView!
    var searchController = UISearchController()
    let historyTableView = UITableView()
    var historyHeightAnchor = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCollectionView()
        setupHistoryTableView()
        bindViewModel()
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let searchBar = self.searchController.searchBar.superview {
            NSLayoutConstraint.activate([
                self.historyTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                self.historyTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.historyTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }

        self.view.layoutIfNeeded()
    }
    
    func bindViewModel() {
       searchViewModel.searchResults.bind { [weak self] _ in
           self?.imagesCollectionView.reloadData()
       }
   }
}
