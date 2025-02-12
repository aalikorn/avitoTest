//
//  ImageInfoViewController+ShareSaveButton.swift
//  avitoTest
//
//  Created by Даша Николаева on 11.09.2024.
//

import UIKit


/// Enum to represent the result of saving an image
enum ImageSaveResult {
    case success
    case failure
}

extension ImageInfoViewController {
    /// Configures the share button's layout and appearance, and adds a target action.
    func configureShareButton() {
        blueSubview.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: blueSubview.topAnchor, constant: 10),
            shareButton.leadingAnchor.constraint(equalTo: blueSubview.leadingAnchor, constant: 10),
            shareButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.43),
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
    
    /// Configures the save button's layout and appearance, and adds a target action.
    func configureSaveButton() {
        blueSubview.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: blueSubview.topAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: blueSubview.trailingAnchor, constant: -10),
            saveButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.43),
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
    
    /// Configures the `blueSubview` that contains the share and save buttons.
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
    
    /// Handles the share button action, opening the share sheet to share the image.
    @objc func shareButtonAction() {
        guard let image = imageView.image else {
            print("Изображение не найдено")
            return
        }
            
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    /// Handles the save button action, saving the image to the user's photo library.
    @objc func saveButtonAction() {
        guard let image = imageView.image else {
            print("Изображение не найдено")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    /// Called when the image has finished saving, and shows a notification of success or failure.
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showNotification(.failure)
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            showNotification(.success)
        }
    }
}
