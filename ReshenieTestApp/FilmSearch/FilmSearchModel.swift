//
//  FilmSearchModel.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2023.
//

import UIKit

protocol FilmSearchModelDelegate: AnyObject {
    func showLoadingView()
    func showLoadingErrorView()
    func showListFilmsView(from: [FilmInfo])
    func showFilmsNotFoundView()
    func showFilmReviewView(id: Int)
    func notifyCompletion()
}

final class FilmSearchModel {
    weak var delegate: FilmSearchModelDelegate?
    var searchWord: String? = nil
    
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func didTapSearchButton() {
        delegate?.showLoadingView()
        getListOfFilms()
    }
    
    func didTapOnUpdateButton() {
        didTapSearchButton()
    }
    
    func didTapFilmAt(id: Int) {
        delegate?.showFilmReviewView(id: id)
    }
    
    func didTapBackButton() {
        delegate?.notifyCompletion()
    }
    
    private func getListOfFilms() {
        guard let searchWord = searchWord else { return }
        let path = "v2.1/films/search-by-keyword"
        let arguments = ["keyword": searchWord]
        
        dataManager.loadData(path: path, arguments: arguments) { [weak self] (result: Result<FilmSearchResult, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.handleSearchResult(result)
            case .failure:
                self.delegate?.showLoadingErrorView()
            }
        }
    }
    
    private func handleSearchResult(_ result: FilmSearchResult) {
        if !result.films.isEmpty {
            var filmInfo = [FilmInfo]()

            for film in result.films {
                let genres: [Genre]
                if film.genres.isEmpty {
                    genres = [Genre(genre: "Неизвестный")]
                } else {
                    genres = film.genres
                }
                
                var filmTitle: String {
                    return film.nameRu ?? film.nameEn ?? "Без названия"
                }
                
                filmInfo.append(
                    FilmInfo(
                        kinopoiskId: film.filmId,
                        nameRu: filmTitle,
                        year: Int(film.year) ?? 0,
                        posterUrlPreview: film.posterUrlPreview,
                        genres: genres
                    )
                )
            }

            delegate?.showListFilmsView(from: filmInfo)
        } else {
            delegate?.showFilmsNotFoundView()
        }
    }
}
