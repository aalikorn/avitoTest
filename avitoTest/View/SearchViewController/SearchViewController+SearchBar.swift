//
//  SearchViewController+SearchBar.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//


import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    /// Configures the search controller and sets its delegate.
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Введите запрос"
    }
    
    /// Handles the event when the search bar ends editing.
        /// Hides the history table view and performs a search if the query is not empty.
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.historyTableView.isHidden = true
        if let query = searchBar.text, !query.isEmpty {
            searchViewModel.performSearch(query)
        }
    }
    
    /// Handles the event when the search bar begins editing.
        /// Displays the history table view with filtered search history.
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchViewModel.searchHistory.count != 0 {
            filterSearchHistory("")
            updateTableViewHeight()
            print(self.filteredHistory)
            self.historyTableView.isHidden = false
            self.historyTableView.reloadData()
        }
        self.view.layoutIfNeeded()
    }
    
    /// Handles changes in the search text.
        /// Filters the search history based on the search text and updates the history table view.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSearchHistory(searchText)
        historyTableView.reloadData()
        historyTableView.isHidden = filteredHistory.isEmpty
    }
}
