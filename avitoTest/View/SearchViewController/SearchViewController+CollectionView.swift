//
//  SearchViewController+CollectionView.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//

import UIKit



extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
           layout.minimumLineSpacing = 10
           layout.minimumInteritemSpacing = 10
           
           imagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           imagesCollectionView.dataSource = self
           imagesCollectionView.delegate = self
           view.addSubview(imagesCollectionView)
           imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
               imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
               imagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.01),
               imagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
        imagesCollectionView.register(MediaItemCollectionViewCell.self, forCellWithReuseIdentifier: "MediaItemCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchResults.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaItemCell", for: indexPath) as! MediaItemCollectionViewCell
        cell.updateConstraintsForLayout(layoutType)
        cell.imageView.image = UIImage(named: "Placeholder")
        let item = searchViewModel.searchResults.value[indexPath.row]
        if let imageURL = URL(string: item.urls.regular) {
            let cacheKey = item.urls.regular
            if let cachedImage = ImageCacheManager.shared.image(forKey: cacheKey) {
                cell.imageView.image = cachedImage
            } else {
                URLSession.shared.dataTask(with: imageURL) { data, _, _ in
                    if let data = data {
                        if let image = UIImage(data: data) {
                            ImageCacheManager.shared.setImage(image, forKey: cacheKey)
                            DispatchQueue.main.async {
                                if collectionView.indexPath(for: cell) == indexPath {
                                    cell.imageView.image = image
                                    cell.setNeedsLayout()
                                    cell.layoutIfNeeded()
                                }
                            }
                        }
                    }
                }.resume()
            }
        }
           cell.authorLabel.text = item.user.username
           cell.descriptionLabel.text = item.description
           
           return cell
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        switch (layoutType) {
        case .grid:
            let numberOfColumns: CGFloat = 2
            let totalSpacing = (numberOfColumns - 1) * spacing + spacing * 2
            let itemWidth = (view.bounds.width - totalSpacing) / numberOfColumns
            let itemHeight: CGFloat = itemWidth * 1.1
            return CGSize(width: itemWidth, height: itemHeight)
        case .list:
            let itemWidth = view.bounds.width - spacing * 2
            let itemHeight: CGFloat = itemWidth * 0.4
            return CGSize(width: itemWidth, height: itemHeight)
        }
           
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = searchViewModel.searchResults.value[indexPath.row]
        let imageInfoViewController = ImageInfoViewController()
        imageInfoViewController.author = item.user
        imageInfoViewController.imageURL = item.urls.regular
        imageInfoViewController.imageDescription = item.description
        navigationController?.pushViewController(imageInfoViewController, animated: true)
    }
    
    func configureErrorLabels() {
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        errorLabel.text = "Возникла ошибка при обработке запроса :( Попробуйте ввести что-то другое"
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .black
        errorLabel.isHidden = true
        errorLabel.textAlignment = .center
        
        view.addSubview(noResultsLabel)
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        noResultsLabel.text = "По такому запросу ничего не найдено :( Попробуйте ввести что-то другое"
        noResultsLabel.numberOfLines = 0
        noResultsLabel.textColor = .black
        noResultsLabel.isHidden = true
        noResultsLabel.textAlignment = .center
    }
    
    func updateUI(with results: [MediaItem]) {
        if results.isEmpty {
            if !isLoading {
                errorLabel.isHidden = true
                noResultsLabel.isHidden = false
                imagesCollectionView.isHidden = true
            }
        } else {
            if isLoading {
                isLoading = false
            }
            loadingLabel.isHidden = true
            noResultsLabel.isHidden = true
            errorLabel.isHidden = true
            imagesCollectionView.isHidden = false
            imagesCollectionView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.noResultsLabel.isHidden = true
            self.errorLabel.isHidden = false
            self.imagesCollectionView.isHidden = true
        }
    }
    
}
