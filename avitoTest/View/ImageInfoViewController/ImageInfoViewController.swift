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
                }
            }
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
    
    func configureShareButton() {
        blueSubview.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: blueSubview.topAnchor, constant: 10),
            shareButton.leadingAnchor.constraint(equalTo: blueSubview.leadingAnchor, constant: 10),
            shareButton.widthAnchor.constraint(equalToConstant: 170),
            shareButton.bottomAnchor.constraint(equalTo: blueSubview.bottomAnchor, constant: -10)
        ])
        shareButton.layer.cornerRadius = 10
        shareButton.layer.borderColor = UIColor.gray.cgColor
        shareButton.layer.borderWidth = 1
        shareButton.backgroundColor = .white
        shareButton.setTitle("поделиться", for: .normal)
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
    }
    
    func configureSaveButton() {
        blueSubview.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: blueSubview.topAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: blueSubview.trailingAnchor, constant: -10),
            saveButton.widthAnchor.constraint(equalToConstant: 170),
            saveButton.bottomAnchor.constraint(equalTo: blueSubview.bottomAnchor, constant: -10)
        ])
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderColor = UIColor.gray.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.backgroundColor = .white
        saveButton.setTitle("сохранить", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
    
    func configureBleuSubview() {
        contentView.addSubview(blueSubview)
        blueSubview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSubview.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            blueSubview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            blueSubview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            blueSubview.heightAnchor.constraint(equalToConstant: 60),
            blueSubview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        let lightBlue = UIColor(red: 225/255.0, green: 243/255.0, blue: 252/255.0, alpha: 1.0)
        blueSubview.backgroundColor = lightBlue
        blueSubview.layer.cornerRadius = 10
    }
    
    @objc func shareButtonAction() {
        guard let image = imageView.image else {
            print("Изображение не найдено")
            return
        }
            
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func saveButtonAction() {
        guard let image = imageView.image else {
            print("Изображение не найдено")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        }
    }
}

