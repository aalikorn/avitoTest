//
//  SearchViewController+SearchBar.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//


import UIKit

extension SearchViewController: UISearchBarDelegate {
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Введите запрос"
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.historyTableView.isHidden = true
        if let query = searchBar.text, !query.isEmpty {
            searchViewModel.performSearch(query)
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchViewModel.searchHistory.count != 0 {
            updateTableViewHeight()
            filterSearchHistory("")
            self.historyTableView.isHidden = false
            self.historyTableView.reloadData()
        }
        self.view.layoutIfNeeded()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSearchHistory(searchText)
        historyTableView.reloadData()
        historyTableView.isHidden = filteredHistory.isEmpty
    }
}
