//
//  ImageViewController.swift
//  avitoTest
//
//  Created by Даша Николаева on 10.09.2024.
//

import UIKit

/// A view controller that displays detailed information about an image, including the image itself, its description, and the author's details.
class ImageInfoViewController: UIViewController {
    
    // MARK: - Properties
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
    
    // MARK: - ScrollView Setup
    /// Adds and configures the scroll view, making sure it fills the entire view.
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
    
    // MARK: - Content View Setup
        /// Sets up the content view within the scroll view and makes its width match the scroll view.
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
    
    // MARK: - Image Loading
        /// Loads the image from the URL, using a placeholder if necessary and caching the loaded image.
    private func loadImage() {
        if let imageURL = imageURL {
            imageView.image = UIImage(named: "Placeholder")
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
    
    // MARK: - UI Configuration
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
        if let author = author {
            authorLabel.font = .systemFont(ofSize: 15)
            authorLabel.text = "автор: \(author.username)"
        } else {
            showAlertError()
            print(2)
        }
    }
    
    // MARK: - Error Handling
        /// Displays an alert when an error occurs and pops the view controller on confirmation.
    func showAlertError() {
        let alert = UIAlertController(title: "Возникла ошибка :(", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setup Views and Constraints
        /// Sets up and adds subviews, and activates constraints for the layout.
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

