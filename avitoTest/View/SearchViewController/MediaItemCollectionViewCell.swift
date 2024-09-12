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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
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
        
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }
    
    /// Updates constraints based on the layout type (grid or list).
    func updateConstraintsForLayout(_ layoutType: LayoutType) {
        NSLayoutConstraint.deactivate(imageView.constraints)
        NSLayoutConstraint.deactivate(descriptionLabel.constraints)
        NSLayoutConstraint.deactivate(authorLabel.constraints)
        
        if layoutType == .grid {
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 150),

                descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                descriptionLabel.heightAnchor.constraint(equalToConstant: 20),

                authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
                authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                authorLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        } else {
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 150),
                imageView.heightAnchor.constraint(equalToConstant: 150),

                descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                descriptionLabel.heightAnchor.constraint(equalToConstant: 130),

                authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                authorLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                authorLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
        }
    }

    /// Prepares the cell for reuse by resetting its content and constraints.
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        descriptionLabel.text = nil
        authorLabel.text = nil
        updateConstraintsForLayout(.grid)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
