//
//  FilmsModel.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

protocol FilmsModelDelegate: AnyObject {
    func showLoadingView()
    func showFilmsView(from data: [FilmInfo])
    func showLoadingErrorView()
    func showFilmReviewView(id: Int)
    func showSearchView()
}

final class FilmsModel {
    weak var delegate: FilmsModelDelegate?
    
    private let requestPath = "api/v2.2/films/premieres?year=2023&month=JUNE"
    
    func viewDidLoad() {
        delegate?.showLoadingView()
        getListOfFilms()
    }
    
    func didTapFilmAt(id: Int) {
        delegate?.showFilmReviewView(id: id)
    }
    
    func didTapSearchButton() {
        delegate?.showSearchView()
    }
    
    func didTapOnUpdateButton() {
        viewDidLoad()
    }
    
    private func getListOfFilms() {
        DataManager.shared.loadData(path: requestPath, completion: { [weak self] (result: Result<Model>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if !data.items.isEmpty {
                    let listOfFilms = self.sortListOfFilms(films: data.items)
                    self.delegate?.showFilmsView(from: listOfFilms)
                } else {
                    self.delegate?.showLoadingErrorView()
                }
            case .failure:
                self.delegate?.showLoadingErrorView()
            }
        })
    }
    
    private func sortListOfFilms(films: [FilmInfo]) -> [FilmInfo] {
        films.sorted(by: { (firstFilm: FilmInfo, secondFilm: FilmInfo) -> Bool in
            return firstFilm.year < secondFilm.year
        })
    }
}
