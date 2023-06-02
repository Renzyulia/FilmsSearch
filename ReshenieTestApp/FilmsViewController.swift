//
//  ViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

class FilmsViewController: UIViewController, FilmsModelDelegate {
    private var filmsTableViewDataSource: FilmsTableViewDataSource? = nil
    private var filmsModel: FilmsModel? = nil
    private var filmsView: FilmView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        view.backgroundColor = .white
        
        let filmsModel = FilmsModel()
        self.filmsModel = filmsModel
        filmsModel.delegate = self
        
        filmsModel.viewDidLoad()
    }
    
    func showLoadingView() {
        
    }
    
    func showFilmsView(from data: [Info]) {
        let filmsTableViewDataSource = FilmsTableViewDataSource(films: data)
        self.filmsTableViewDataSource = filmsTableViewDataSource

        let filmsView = FilmsView(tableViewDataSource: filmsTableViewDataSource, tableViewDelegate: filmsTableViewDataSource, identifierCell: filmsTableViewDataSource.reuseIdentifier)

        view.addSubview(filmsView)

        filmsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmsView.topAnchor.constraint(equalTo: view.topAnchor),
            filmsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            filmsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            filmsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showLoadingErrorView() {
        //показать ошибку загрузки данных
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

