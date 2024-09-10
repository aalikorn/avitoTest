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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCollectionView()
        imagesCollectionView.register(MediaItemCollectionViewCell.self, forCellWithReuseIdentifier: "MediaItemCell")
        bindViewModel()
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
       searchViewModel.searchResults.bind { [weak self] _ in
           self?.imagesCollectionView.reloadData()
       }
   }
}
