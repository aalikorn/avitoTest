//
//  ImageSavedNotification.swift
//  avitoTest
//
//  Created by Даша Николаева on 11.09.2024.
//

import UIKit

extension ImageInfoViewController {
    func configureNotificationView() {
        contentView.addSubview(notificationView)
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            notificationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            notificationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            notificationView.heightAnchor.constraint(equalToConstant: 70)
        ])
        notificationView.layer.cornerRadius = 10
        let lightBlue = UIColor(red: 225/255.0, green: 243/255.0, blue: 252/255.0, alpha: 1.0)
        notificationView.backgroundColor = lightBlue
        configureNotficationLabel()
        notificationView.alpha = 0
    }
    
    func configureNotficationLabel() {
        notificationView.addSubview(notificationLabel)
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
               notificationLabel.centerXAnchor.constraint(equalTo: notificationView.centerXAnchor),
               notificationLabel.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor),
               notificationLabel.widthAnchor.constraint(equalToConstant: 250)
           ])
        notificationLabel.textColor = .black
        notificationLabel.numberOfLines = 0
        notificationLabel.textAlignment = .center
    }
    
    func showNotification(_ result: ImageSaveResult) {
        switch result {
        case .failure: notificationLabel.text = "Пожалуйста, разрешите приложению доступ к галерее в настройках"
        case .success: notificationLabel.text = "Изображение сохранено"
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.notificationView.alpha = 0.9
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
                self.notificationView.alpha = 0
            })
            
        }
    }
}
