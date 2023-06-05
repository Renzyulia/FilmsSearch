//
//  FilmSearchViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2023.
//

import UIKit

final class FilmSearchViewController: UIViewController, FilmSearchModelDelegate, FilmsTableViewDataSourceDelegate, LoadingErrorViewDelegate, FilmReviewViewControllerDelegate {
    
    weak var delegate: FilmSearchViewControllerDelegate?
    var filmSearchTextDelegate: FilmSearchTextDelegate? = nil
    
    private var filmSearchModel: FilmSearchModel? = nil
    private var filmsView: FilmsView? = nil
    private var filmsTableViewDataSource: FilmsTableViewDataSource? = nil
    private var loadingView: LoadingView? = nil
    private var filmsNotFoundView: FilmsNotFoundView? = nil
    private var loadingErrorView: LoadingErrorView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filmSearchModel = FilmSearchModel()
        self.filmSearchModel = filmSearchModel
        filmSearchModel.delegate = self
        
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    func showLoadingView() {
        let loadingView = LoadingView()
        self.loadingView = loadingView
        
        filmsNotFoundView?.removeFromSuperview()
        loadingErrorView?.removeFromSuperview()
        filmsView?.removeFromSuperview()
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    func showFilmsNotFoundView() {
        let filmsNotFoundView = FilmsNotFoundView()
        self.filmsNotFoundView = filmsNotFoundView
        
        loadingView?.removeFromSuperview()
        view.addSubview(filmsNotFoundView)
        
        filmsNotFoundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmsNotFoundView.topAnchor.constraint(equalTo: view.topAnchor),
            filmsNotFoundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            filmsNotFoundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            filmsNotFoundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showListFilmsView(from data: [Info]) {
        let filmsTableViewDataSource = FilmsTableViewDataSource(films: data)
        self.filmsTableViewDataSource = filmsTableViewDataSource
        filmsTableViewDataSource.delegate = self

        let filmsView = FilmsView(tableViewDataSource: filmsTableViewDataSource, tableViewDelegate: filmsTableViewDataSource, identifierCell: filmsTableViewDataSource.reuseIdentifier)
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
    
    func didTapOnUpdateButton() {
        filmSearchModel?.didTapSearchButton()
    }
    
    func didTapFilmAt(id: Int) {
        filmSearchModel?.didTapFilmAt(id: id)
    }
    
    func showFilmReviewView(id: Int) {
        let filmReviewViewController = FilmReviewViewController(filmID: id)
        filmReviewViewController.delegate = self
        
        navigationController?.pushViewController(filmReviewViewController, animated: false)
    }
    
    func onFinish() {
        navigationController?.popViewController(animated: false)
    }
    
    func notifyCompletion() {
        delegate?.onFinish()
    }
    
    private func configureNavigationBar() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "CustomColor")
        
        let filmSearchTextDelegate = FilmSearchTextDelegate()
        self.filmSearchTextDelegate = filmSearchTextDelegate
        filmSearchTextDelegate.delegate = filmSearchModel
        
        let searchView = UITextField()
        searchView.placeholder = "Поиск"
        searchView.font = UIFont.specialFont(size: 20, style: .regular)
        searchView.textColor = .black
        searchView.textAlignment = .left
        searchView.returnKeyType = UIReturnKeyType.search
        searchView.delegate = filmSearchTextDelegate
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(didTapBackButton))
        backButton.tintColor = UIColor(named: "CustomColor")
        
        let searchButton = UIBarButtonItem(customView: searchView)
        
        navigationItem.leftBarButtonItems = [backButton, searchButton]
    }
    
    @objc private func didTapBackButton() {
        filmSearchModel?.didTapBackButton()
    }
}

protocol FilmSearchViewControllerDelegate: AnyObject {
    func onFinish()
}
