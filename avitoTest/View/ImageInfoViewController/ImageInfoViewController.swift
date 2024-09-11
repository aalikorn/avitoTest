//
//  ImageViewController.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//

import UIKit

class ImageInfoViewController: UIViewController {
    
    var imageURL: String?
    var imageDescription: String?
    var author: User?
    
    var imageView = UIImageView()
    var descriptionLabel = UILabel()
    var authorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func loadImage() {
        if let imageURL = imageURL {
            if let cachedImage = ImageCacheManager.shared.image(forKey: imageURL) {
                imageView.image = cachedImage
            } else {
                if let url = URL(string: imageURL) {
                    print(url)
                    URLSession.shared.dataTask(with: url) { data, _, _ in
                        print(1)
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        }
                    }
                }
            }
        }
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        loadImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
    }
    
    func configureDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = imageDescription
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
    }
    
    func configureAuthorLabel() {
        view.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = author?.username
        authorLabel.font = .systemFont(ofSize: 15)
    }
    
    func setupViews() {
        configureImageView()
        configureDescriptionLabel()
        configureAuthorLabel()
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
}
