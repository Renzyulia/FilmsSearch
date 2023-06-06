//
//  ViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

class FilmsViewController: UIViewController, FilmsModelDelegate, FilmsTableViewDataSourceDelegate, FilmReviewViewControllerDelegate, FilmSearchViewControllerDelegate, LoadingErrorViewDelegate {
    
    private lazy var filmsModel = {
        let model = FilmsModel(dataManager: .shared)
        model.delegate = self
        return model
    }()
    
    private var filmsView: FilmsView? = nil
    private var filmsTableViewDataSource: FilmsTableViewDataSource? = nil
    private var loadingView: LoadingView? = nil
    private var loadingErrorView: LoadingErrorView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        view.backgroundColor = .white

        filmsModel.viewDidLoad()
    }
    
    func showLoadingView() {
        let loadingView = LoadingView()
        self.loadingView = loadingView
        
        loadingErrorView?.removeFromSuperview()
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showFilmsView(from data: [FilmInfo]) {
        let filmsTableViewDataSource = FilmsTableViewDataSource(films: data)
        self.filmsTableViewDataSource = filmsTableViewDataSource
        filmsTableViewDataSource.delegate = self

        let filmsView = FilmsView(dataSource: filmsTableViewDataSource)
        self.filmsView = filmsView

        loadingView?.removeFromSuperview()
        view.addSubview(filmsView)

        filmsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filmsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            filmsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            filmsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showLoadingErrorView() {
        let loadingErrorView = LoadingErrorView()
        self.loadingErrorView = loadingErrorView
        loadingErrorView.delegate = self
        
        loadingView?.removeFromSuperview()
        view.addSubview(loadingErrorView)
        
        loadingErrorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingErrorView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingErrorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingErrorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingErrorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func didTapOnUpdateButton() {
        filmsModel.didTapOnUpdateButton()
    }
    
    func didTapFilmAt(id: Int) {
        filmsModel.didTapFilmAt(id: id)
    }
    
    func showFilmReviewView(id: Int) {
        let filmReviewViewController = FilmReviewViewController(filmID: id)
        filmReviewViewController.delegate = self
        
        navigationController?.pushViewController(filmReviewViewController, animated: false)
    }
    
    func showSearchView() {
        let filmSearchViewController = FilmSearchViewController()
        filmSearchViewController.delegate = self
        
        navigationController?.pushViewController(filmSearchViewController, animated: false)
    }
    
    func onFinish() {
        navigationController?.popViewController(animated: false)
    }
    
    private func configureNavigationBar() {
        let titleLabel = UILabel()
        let title = NSAttributedString(
            string: "Фильмы",
            attributes: [
                .font: UIFont.specialFont(size: 25, style: .medium),
                .foregroundColor: UIColor.black
            ]
        )
        
        titleLabel.attributedText = title
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        let searchIcon = UIImage.searchIcon.withTintColor(.customColor, renderingMode: .alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(didTapSearchButton))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func didTapSearchButton() {
        filmsModel.didTapSearchButton()
    }
}

