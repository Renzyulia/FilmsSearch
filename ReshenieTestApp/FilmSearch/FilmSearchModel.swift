//
//  FilmSearchModel.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2023.
//

import UIKit

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
                                             genres: [Genre(genre: "Unknown")])) //как это реализовать в методе с популярными фильмами
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
        
//        var request = URLRequest(url: URL(string: "\(requestURL)" + "\(searchWord)")!)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
//
//        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error -> Void in
//          do {
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    self?.delegate?.showLoadingErrorView()
//                }
//                return
//            }
//
//            let jsonDecoder = JSONDecoder()
//            let responseModel = try jsonDecoder.decode(FindedFilms.self, from: data) //??
//
//            DispatchQueue.main.async {
//                var info = [FilmInfo]()
//
//                for film in responseModel.films {
//                    if film.genres.isEmpty {
//                        info.append(FilmInfo(kinopoiskId: film.filmId,
//                                         nameRu: film.nameRu,
//                                         year: Int(film.year) ?? 0,
//                                         posterUrlPreview: film.posterUrlPreview,
//                                         genres: [Genre(genre: "Unknown")])) //как это реализовать в методе с популярными фильмами
//                    } else {
//                        info.append(FilmInfo(kinopoiskId: film.filmId,
//                                         nameRu: film.nameRu,
//                                         year: Int(film.year) ?? 0,
//                                         posterUrlPreview: film.posterUrlPreview,
//                                         genres: film.genres))
//                    }
//                }
//
//                self?.delegate?.showListFilmsView(from: info)
//            }
//          } catch {
//              DispatchQueue.main.async {
//                  self?.delegate?.showFilmsNotFoundView()
//              }
//            }
//        }).resume()
    }
}

protocol FilmSearchModelDelegate: AnyObject {
    func showLoadingView()
    func showLoadingErrorView()
    func showListFilmsView(from: [FilmInfo])
    func showFilmsNotFoundView()
    func showFilmReviewView(id: Int)
    func notifyCompletion()
}

struct FindedFilms: Decodable {
    let films: [Films]
}

struct Films: Decodable {
    let filmId: Int
    let nameRu: String
    let year: String
    let genres: [Genre]
    let posterUrlPreview: URL
}
