//
//  FilmReviewModel.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 03.06.2023.
//

import UIKit

protocol FilmReviewModelDelegate: AnyObject {
    func showLoadingView()
    func showFilmReviewView(posterUrl: URL, title: String, review: String, genres: [String], countries: [String], year: Int)
    func showLoadingErrorView()
    func notifyCompletion()
}

final class FilmReviewModel {
    weak var delegate: FilmReviewModelDelegate?
    
    private let filmID: Int
    private let requestPath = "api/v2.2/films/"
    
    init(filmID: Int) {
        self.filmID = filmID
    }
    
    func viewDidLoad() {
        delegate?.showLoadingView()
        getFilmDetails()
    }
    
    func didTapBackButton() {
        delegate?.notifyCompletion()
    }
    
    func didTapOnUpdateButton() {
        viewDidLoad()
    }
    
    private func getFilmDetails() {
        DataManager.shared.loadData(path: requestPath + String(filmID), completion: { [weak self] (result: Result<FilmDetails>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                var listGenres = [String]()
                var countries = [String]()
                    
                for genre in data.genres {
                    listGenres.append(genre.genre)
                }
                    
                for country in data.countries {
                    countries.append(country.country)
                }
                    
                self.delegate?.showFilmReviewView(
                    posterUrl: data.posterUrl,
                    title: data.nameRu,
                    review: data.description,
                    genres: listGenres,
                    countries: countries,
                    year: data.year)
            case .failure:
                self.delegate?.showLoadingErrorView()
            }
        })
    }
}
