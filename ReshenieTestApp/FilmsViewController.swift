//
//  ViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

class FilmsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        // MARK: - configure title
        let titleLabel = UILabel()
        let title = NSAttributedString(
            string: "Фильмы",
            attributes: [
                .font: UIFont.specialFont(size: 25, style: .medium),
                .foregroundColor: UIColor.black
            ]
        )
        
        titleLabel.attributedText = title
        titleLabel.textAlignment = .left
        
        navigationBar.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -5)
        ])
        
        // MARK: - configure searchButton
        let searchButton = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .plain, target: self, action: #selector(didTapSearchButton))
        
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func didTapSearchButton() {
        print("Search")
    }
}

