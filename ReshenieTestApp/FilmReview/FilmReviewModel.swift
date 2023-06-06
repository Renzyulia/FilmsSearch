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
    private let dataManager: DataManager
    
    init(filmID: Int, dataManager: DataManager) {
        self.filmID = filmID
        self.dataManager = dataManager
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
        let path = "v2.2/films/\(filmID)"
        dataManager.loadData(path: path) { [weak self] (result: Result<FilmDetails, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let filmDetails):
                self.handleLoadedFilm(filmDetails)
            case .failure:
                self.delegate?.showLoadingErrorView()
            }
        }
    }
    
    private func handleLoadedFilm(_ film: FilmDetails) {
        var listGenres = [String]()
        var countries = [String]()
            
        for genre in film.genres {
            listGenres.append(genre.genre)
        }
            
        for country in film.countries {
            countries.append(country.country)
        }
        
        var filmTitle: String {
            return film.nameRu ?? film.nameEn ?? "Без названия"
        }
        
        var description: String {
            return film.description ?? "Описание отсутствует"
        }
            
        delegate?.showFilmReviewView(
            posterUrl: film.posterUrl,
            title: filmTitle,
            review: description,
            genres: listGenres,
            countries: countries,
            year: film.year
        )
    }
}
