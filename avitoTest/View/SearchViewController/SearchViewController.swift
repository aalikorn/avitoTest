//
//  SearchViewController.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//

import UIKit

// Represents types of content representation. Switching between them in the development yet :(
enum LayoutType {
    case grid
    case list
}

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
    var layoutType: LayoutType = .grid {
        didSet {
            // Reload the collection view when the layout type changes
            imagesCollectionView.reloadData()
        }
    }
    
    /// Configures the navigation bar with a toggle layout button.
    func configureNavigationBar() {
        let toggleLayoutButton = UIBarButtonItem(
            title: "Отображать списком",
            style: .plain,
            target: self,
            action: #selector(toggleLayout)
        )
        navigationItem.rightBarButtonItem = toggleLayoutButton
    }

    /// Toggles between grid and list layout types.
    @objc func toggleLayout() {
        layoutType = (layoutType == .grid) ? .list : .grid
        
        let buttonTitle = (layoutType == .grid) ? "Отображать списком" : "Отображать сеткой"
        navigationItem.rightBarButtonItem?.title = buttonTitle
    }

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
        
        // Ensure constraints for historyTableView are activated if searchBar is in view hierarchy
        if let searchBar = self.searchController.searchBar.superview {
            NSLayoutConstraint.activate([
                self.historyTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                self.historyTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.historyTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
        
        self.view.layoutIfNeeded()
    }
    
    /// Binds the search results from the view model to update the UI.
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
    
    /// Binds error state from the view model to show error messages.
    func bindError() {
        searchViewModel.error.bind { [weak self] _ in
            DispatchQueue.main.async {
                if self?.searchViewModel.error.value == true {
                    self?.showError()
                }
            }
        }
    }
    
    /// Displays a loading label.
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
