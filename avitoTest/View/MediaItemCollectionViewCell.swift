//
//  MediaItemCollectionViewCell.swift
//  avitoTest
//
//  Created by Даша Николаева on 08.09.2024.
//

import UIKit

class MediaItemCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
