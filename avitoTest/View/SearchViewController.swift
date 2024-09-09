//
//  ViewController.swift
//  avitoTest
//
//  Created by Даша Николаева on 07.09.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchViewModel = SearchViewModel()
    var imagesCollectionView: UICollectionView!
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCollectionView()
        imagesCollectionView.register(MediaItemCollectionViewCell.self, forCellWithReuseIdentifier: "MediaItemCell")
        bindViewModel()
    }
    
    func bindViewModel() {
       searchViewModel.searchResults.bind { [weak self] _ in
           self?.imagesCollectionView.reloadData()
       }
   }
}


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

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        imagesCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        view.addSubview(imagesCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchResults.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaItemCell", for: indexPath) as! MediaItemCollectionViewCell
        let item = searchViewModel.searchResults.value[indexPath.row]
        if let imageURL = URL(string: item.urls.full) {
            URLSession.shared.dataTask(with: imageURL) { data, _, _ in
                if let data = data {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imageView.image = image
                        }
                    }
                }
            }.resume()
        }
        cell.authorLabel.text = item.user.username
        cell.descriptionLabel.text = item.description
        
        return cell
    }
}

