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
    let scrollView = UIScrollView()
    let contentView = UIView()
    let blueSubview = UIView()
    let shareButton = UIButton()
    let saveButton = UIButton()
    let notificationView = UIView()
    let notificationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupScrollView() {
       view.addSubview(scrollView)
       scrollView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
           scrollView.topAnchor.constraint(equalTo: view.topAnchor),
           scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
       ])
   }
    
    private func setupContentView() {
       scrollView.addSubview(contentView)
       contentView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
           contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
           contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
           contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
           contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
           contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
       ])
   }
    
    private func loadImage() {
        if let imageURL = imageURL {
            if let cachedImage = ImageCacheManager.shared.image(forKey: imageURL) {
                imageView.image = cachedImage
            } else {
                if let url = URL(string: imageURL) {
                    URLSession.shared.dataTask(with: url) { data, _, _ in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        }
                    }
                } else {
                    showAlertError()
                }
            }
        } else {
            showAlertError()
        }
    }
    
    func configureImageView() {
        loadImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = imageDescription
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
    }
    
    func configureAuthorLabel() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = author?.username
        authorLabel.font = .systemFont(ofSize: 15)
    }
    
    func showAlertError() {
        let alert = UIAlertController(title: "Возникла ошибка :(", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func setupViews() {
        setupScrollView()
        setupContentView()
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(authorLabel)
        configureImageView()
        configureDescriptionLabel()
        configureAuthorLabel()
        configureBleuSubview()
        configureShareButton()
        configureSaveButton()
        configureNotificationView()
        NSLayoutConstraint.activate([
           imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
           imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
           imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
           imageView.heightAnchor.constraint(equalToConstant: 300),

           descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
           descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
           descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

           authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
           authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
           authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
           authorLabel.heightAnchor.constraint(equalToConstant: 15)
       ])
    }
    
}

