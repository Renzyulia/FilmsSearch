//
//  FilmSearchViewController.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2023.
//

import UIKit

final class FilmSearchViewController: UIViewController {
    weak var delegate: FilmSearchViewControllerDelegate?
    weak var searchTextDelegate: FilmSearchTextDelegate? = nil
    
    private var filmSearchModel: FilmSearchModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    func notifyCompletion() {
        delegate?.onFinish()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .plain, target: self, action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "CustomColor")
        
        let searchView = UITextField()
        let searchTextDelegate = FilmSearchTextDelegate()
        searchView.placeholder = "Поиск"
        searchView.font = UIFont.specialFont(size: 20, style: .regular)
        searchView.textColor = .gray
        searchView.textAlignment = .left
        searchView.delegate = searchTextDelegate
        
        navigationItem.titleView = searchView
    }
    
    @objc private func didTapBackButton() {
        filmSearchModel?.didTapBackButton()
    }
}

protocol FilmSearchViewControllerDelegate: AnyObject {
    func onFinish()
}
