//
//  FilmSearchViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2023.
//

import UIKit

final class FilmSearchViewController: UIViewController, FilmSearchModelDelegate, FilmsTableViewDataSourceDelegate {
    weak var delegate: FilmSearchViewControllerDelegate?
    var filmSearchTextDelegate: FilmSearchTextDelegate? = nil
    
    private var filmSearchModel: FilmSearchModel? = nil
    private var filmsView: FilmsView? = nil
    private var filmsTableViewDataSource: FilmsTableViewDataSource? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filmSearchModel = FilmSearchModel()
        self.filmSearchModel = filmSearchModel
        filmSearchModel.delegate = self
        
        view.backgroundColor = .white
        configureNavigationBar()
        
        print("view did load")
    }
    
    func showListFilmsView(from data: [Info]) {
        let filmsTableViewDataSource = FilmsTableViewDataSource(films: data)
        self.filmsTableViewDataSource = filmsTableViewDataSource
        filmsTableViewDataSource.delegate = self

        let filmsView = FilmsView(tableViewDataSource: filmsTableViewDataSource, tableViewDelegate: filmsTableViewDataSource, identifierCell: filmsTableViewDataSource.reuseIdentifier)
        self.filmsView = filmsView

        view.addSubview(filmsView)

        filmsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filmsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            filmsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            filmsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func didTapFilmAt(id: Int) {
    }
    
    func notifyCompletion() {
        delegate?.onFinish()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "CustomColor")
        
        let filmSearchTextDelegate = FilmSearchTextDelegate()
        self.filmSearchTextDelegate = filmSearchTextDelegate
        filmSearchTextDelegate.delegate = filmSearchModel
        
        let searchView = UITextField()
        searchView.placeholder = "Поиск"
        searchView.font = UIFont.specialFont(size: 20, style: .regular)
        searchView.textColor = .gray
        searchView.textAlignment = .left
        searchView.returnKeyType = UIReturnKeyType.search
        searchView.delegate = filmSearchTextDelegate
        
        navigationItem.titleView = searchView
    }
    
    @objc private func didTapBackButton() {
        filmSearchModel?.didTapBackButton()
    }
}

protocol FilmSearchViewControllerDelegate: AnyObject {
    func onFinish()
}
