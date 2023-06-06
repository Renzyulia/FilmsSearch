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
    
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
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
        let requestPath = "v2.2/films/premieres"
        let arguments = ["year": "2023", "month": "JUNE"]
        dataManager.loadData(path: requestPath, arguments: arguments) { [weak self] (result: Result<Films, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if !data.items.isEmpty {
                    let listOfFilms = self.sortedByYear(data.items)
                    self.delegate?.showFilmsView(from: listOfFilms)
                } else {
                    self.delegate?.showLoadingErrorView()
                }
            case .failure:
                self.delegate?.showLoadingErrorView()
            }
        }
    }
    
    private func sortedByYear(_ films: [FilmInfo]) -> [FilmInfo] {
        return films.sorted { firstFilm, secondFilm in
            return firstFilm.year < secondFilm.year
        }
    }
}
