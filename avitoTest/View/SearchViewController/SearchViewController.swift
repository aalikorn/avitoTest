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
    var filteredHistory: [String] = []
    var errorLabel = UILabel()
    var noResultsLabel = UILabel()
    var loadingLabel = UILabel()
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCollectionView()
        setupHistoryTableView()
        showLoading()
        bindViewModel()
        bindError()
        searchViewModel.performSearch()
        configureErrorLabels()
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
            DispatchQueue.global(qos: .userInitiated).async {
                let results = self?.searchViewModel.searchResults.value ?? []
                
                DispatchQueue.main.async {
                    self?.updateUI(with: results)
                    self?.imagesCollectionView.reloadData()
                }
            }
        }
    }
    
    func bindError() {
        searchViewModel.error.bind { [weak self] _ in
            DispatchQueue.main.async {
                if self?.searchViewModel.error.value == true {
                    self?.showError()
                }
            }
        }
    }
    
    func showLoading() {
        view.addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        loadingLabel.text = "Загрузка..."
        loadingLabel.numberOfLines = 0
        loadingLabel.textColor = .black
        loadingLabel.textAlignment = .center
    }
}
