//
//  FilmReviewViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 03.06.2023.
//

import UIKit

protocol FilmReviewViewControllerDelegate: AnyObject {
    func onFinish()
}

final class FilmReviewViewController: UIViewController, FilmReviewModelDelegate, LoadingErrorViewDelegate {
    weak var delegate: FilmReviewViewControllerDelegate?
    
    private let filmID: Int
    
    private lazy var filmReviewModel = {
        let model = FilmReviewModel(filmID: filmID, dataManager: DataManager.shared)
        model.delegate = self
        return model
    }()
    
    private var filmReviewView: FilmReviewView?
    private var loadingView: LoadingView?
    private var loadingErrorView: LoadingErrorView?
    
    init(filmID: Int) {
        self.filmID = filmID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        view.backgroundColor = .white
        
        filmReviewModel.viewDidLoad()
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
    
    func showFilmReviewView(posterUrl: URL, title: String, review: String, genres: [String], countries: [String], year: Int) {
        let filmReviewView = FilmReviewView(posterUrl: posterUrl, titleFilm: title, reviewFilm: review, genres: genres, countries: countries, year: year)
        self.filmReviewView = filmReviewView
        
        loadingView?.removeFromSuperview()
        view.addSubview(filmReviewView)
        
        filmReviewView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmReviewView.topAnchor.constraint(equalTo: view.topAnchor),
            filmReviewView.leftAnchor.constraint(equalTo: view.leftAnchor),
            filmReviewView.rightAnchor.constraint(equalTo: view.rightAnchor),
            filmReviewView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func didTapOnUpdateButton() {
        filmReviewModel.didTapOnUpdateButton()
    }
    
    func notifyCompletion() {
        delegate?.onFinish()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .backIcon, style: .plain, target: self, action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem?.tintColor = .customColor
    }
    
    @objc private func didTapBackButton() {
        filmReviewModel.didTapBackButton()
    }
}
