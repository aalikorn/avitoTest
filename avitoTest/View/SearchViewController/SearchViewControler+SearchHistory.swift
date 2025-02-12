//
//  SearchViewControler+SearchHistory.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Sets up the history table view.
    func setupHistoryTableView() {
        view.addSubview(historyTableView)
        historyTableView.isHidden = true
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "historyCell")
        historyTableView.layer.borderColor = UIColor.gray.cgColor
        historyTableView.layer.borderWidth = 0.4
        historyTableView.layer.cornerRadius = 10
        
        DispatchQueue.main.async {
            guard let searchBar = self.searchController.searchBar.superview else {
                print("searchController.searchBar is not in the view hierarchy yet")
                return
            }
            self.historyHeightAnchor = self.historyTableView.heightAnchor.constraint(equalToConstant: 300)
            NSLayoutConstraint.activate([
                self.historyTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                self.historyTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.historyTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = filteredHistory[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = filteredHistory[indexPath.row]
        searchController.searchBar.text = query
        searchViewModel.performSearch(query)
        historyTableView.isHidden = true
        searchController.searchBar.endEditing(true)
    }
    
    func updateTableViewHeight() {
        historyHeightAnchor.isActive = false
        let numberOfRows = filteredHistory.count
        let rowHeight: CGFloat = 48
        let totalHeight = CGFloat(numberOfRows) * rowHeight
        historyHeightAnchor = self.historyTableView.heightAnchor.constraint(equalToConstant: totalHeight)
        historyHeightAnchor.isActive = true
    }
    
    func addBottomBorder(to view: UIView, height: CGFloat, color: UIColor) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.heightAnchor.constraint(equalToConstant: height),
            border.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func filterSearchHistory(_ query: String) {
        let history = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? []
        if query.isEmpty {
            filteredHistory = history
            historyTableView.reloadData()
            historyTableView.isHidden = false
        } else {
            filteredHistory = history.filter { $0.range(of: query, options: .caseInsensitive) != nil }
            historyTableView.reloadData()
            historyTableView.isHidden = false
        }
    }
}

