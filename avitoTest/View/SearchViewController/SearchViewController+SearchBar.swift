//
//  SearchViewController+SearchBar.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//

import Foundation

import UIKit

extension SearchViewController: UISearchBarDelegate {
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.isEmpty {
            searchViewModel.performSearch(query)
        }
    }
}
