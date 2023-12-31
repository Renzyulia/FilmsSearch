//
//  FilmSearchViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2022.
//

import UIKit

protocol FilmSearchViewControllerDelegate: AnyObject {
    func onFinish()
}

final class FilmSearchViewController: UIViewController, FilmSearchModelDelegate, FilmsTableViewDataSourceDelegate, LoadingErrorViewDelegate, FilmReviewViewControllerDelegate {
    
    weak var delegate: FilmSearchViewControllerDelegate?
    var filmSearchTextDelegate: FilmSearchTextDelegate? = nil
    
    private lazy var filmSearchModel = {
        let model = FilmSearchModel(dataManager: DataManager.shared)
        model.delegate = self
        return model
    }()
    
    private var filmsView: FilmsView? = nil
    private var filmsTableViewDataSource: FilmsTableViewDataSource? = nil
    private var loadingView: LoadingView? = nil
    private var filmsNotFoundView: FilmsNotFoundView? = nil
    private var loadingErrorView: LoadingErrorView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func showListFilmsView(from data: [FilmInfo]) {
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
    
    func didTapOnUpdateButton() {
        filmSearchModel.didTapSearchButton()
    }
    
    func didTapFilmAt(id: Int) {
        filmSearchModel.didTapFilmAt(id: id)
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
        
        let searchButton = UIBarButtonItem(customView: searchView)
        
        let backButton = UIBarButtonItem(image: .backIcon, style: .plain, target: self, action: #selector(didTapBackButton))
        backButton.tintColor = .customColor
        
        navigationItem.leftBarButtonItems = [backButton, searchButton]
    }
    
    @objc private func didTapBackButton() {
        filmSearchModel.didTapBackButton()
    }
}
