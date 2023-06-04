//
//  FilmReviewViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 03.06.2023.
//

import UIKit

final class FilmReviewViewController: UIViewController, FilmReviewModelDelegate, LoadingErrorViewDelegate {
    let filmID: Int
    weak var delegate: FilmReviewViewControllerDelegate?
    
    private var filmReviewModel: FilmReviewModel? = nil
    private var filmReviewView: FilmReviewView? = nil
    private var loadingView: LoadingView? = nil
    private var loadingErrorView: LoadingErrorView? = nil
    
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
        
        let filmReviewModel = FilmReviewModel(filmID: filmID)
        self.filmReviewModel = filmReviewModel
        filmReviewModel.delegate = self
        
        filmReviewModel.viewDidLoad()
    }
    
    func showLoadingView() {
        let loadingView = LoadingView()
        self.loadingView = loadingView
        
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
        filmReviewModel?.didTapOnUpdateButton()
    }
    
    func notifyCompletion() {
        delegate?.onFinish()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "CustomColor")
    }
    
    @objc private func didTapBackButton() {
        filmReviewModel?.didTapBackButton()
    }
}

protocol FilmReviewViewControllerDelegate: AnyObject {
    func onFinish()
}
