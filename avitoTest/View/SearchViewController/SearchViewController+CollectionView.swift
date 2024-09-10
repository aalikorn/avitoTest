//
//  SearchViewController+CollectionView.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//

import Foundation

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
               imagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
               imagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
           ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchResults.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaItemCell", for: indexPath) as! MediaItemCollectionViewCell
           let item = searchViewModel.searchResults.value[indexPath.row]
        if let imageURL = URL(string: item.urls.full) {
            let cacheKey = item.urls.full
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
            let numberOfColumns: CGFloat = 2
            let spacing: CGFloat = 10
            let totalSpacing = (numberOfColumns - 1) * spacing + spacing * 2
            let itemWidth = (view.bounds.width - totalSpacing) / numberOfColumns
            let itemHeight: CGFloat = itemWidth * 1.1
            return CGSize(width: itemWidth, height: itemHeight)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = searchViewModel.searchResults.value[indexPath.row]
        var imageInfoViewController = ImageInfoViewController()
        navigationController?.pushViewController(imageInfoViewController, animated: true)
    }
}
