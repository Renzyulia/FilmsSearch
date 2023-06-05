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
    
    private let requestPath = "api/v2.1/films/search-by-keyword?keyword="
    
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
    
    private func transformSearchWord() -> String? {
        return searchWord?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    private func getListOfFilms() {
        guard searchWord != nil else { return }
        guard let searchWord = transformSearchWord() else { return }
        
        DataManager.shared.loadData(path: requestPath + searchWord, completion: { [weak self] (result: Result<FindedFilms>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if !data.films.isEmpty {
                    var filmIinfo = [FilmInfo]()

                    for film in data.films {
                        if film.genres.isEmpty {
                            filmIinfo.append(FilmInfo(kinopoiskId: film.filmId,
                                             nameRu: film.nameRu,
                                             year: Int(film.year) ?? 0,
                                             posterUrlPreview: film.posterUrlPreview,
                                             genres: [Genre(genre: "Unknown")]))
                        } else {
                            filmIinfo.append(FilmInfo(kinopoiskId: film.filmId,
                                             nameRu: film.nameRu,
                                             year: Int(film.year) ?? 0,
                                             posterUrlPreview: film.posterUrlPreview,
                                             genres: film.genres))
                        }
                    }

                    self.delegate?.showListFilmsView(from: filmIinfo)
                } else {
                    self.delegate?.showFilmsNotFoundView()
                }
            case .failure:
                self.delegate?.showLoadingErrorView()
            }
        })
    }
}
