//
//  LaunchScreenViewController.swift
//  avitoTest
//
//  Created by Даша Николаева on 12.09.2024.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            view.addSubview(logoImageView)
            
            NSLayoutConstraint.activate([
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                logoImageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
                logoImageView.heightAnchor.constraint(equalToConstant: view.frame.width * 0.7)
            ])
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.goToMainScreen()
            }
        }
        
        func goToMainScreen() {
            let searchViewController = SearchViewController()
            let navigationController = UINavigationController(rootViewController:  searchViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
}

