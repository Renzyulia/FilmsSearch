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
    
    private let apiKey = "fb5368f8-d311-48d9-aadf-c3bd71bda8c5"
    private let requestURL = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword="
    
    func didTapSearchButton() {
        delegate?.showLoadingView()
        getListOfFilms()
    }
    
    func didTapBackButton() {
        delegate?.notifyCompletion()
    }
    
    func didTapOnUpdateButton() {
        didTapSearchButton()
    }
    
    private func transformSearchWord() -> String? {
        return searchWord?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    private func getListOfFilms() {
        guard searchWord != nil else { return }
        guard let searchWord = transformSearchWord() else { return }
        
        var request = URLRequest(url: URL(string: "\(requestURL)" + "\(searchWord)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
      
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error -> Void in
          do {
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.delegate?.showLoadingErrorView()
                }
                return
            }
              
            let jsonDecoder = JSONDecoder()
            let responseModel = try jsonDecoder.decode(FindedFilms.self, from: data) //??
            
            DispatchQueue.main.async {
                var info = [Info]()
                
                for film in responseModel.films {
                    if film.genres.isEmpty {
                        info.append(Info(kinopoiskId: film.filmId,
                                         nameRu: film.nameRu,
                                         year: Int(film.year) ?? 0,
                                         posterUrlPreview: film.posterUrlPreview,
                                         genres: [Genre(genre: "Unknown")])) //как это реализовать в методе с популярными фильмами
                    } else {
                        info.append(Info(kinopoiskId: film.filmId,
                                         nameRu: film.nameRu,
                                         year: Int(film.year) ?? 0,
                                         posterUrlPreview: film.posterUrlPreview,
                                         genres: film.genres))
                    }
                }
                
                self?.delegate?.showListFilmsView(from: info)
            }
          } catch {
              DispatchQueue.main.async {
                  self?.delegate?.showFilmsNotFoundView()
              }
            }
        }).resume()
    }
}

protocol FilmSearchModelDelegate: AnyObject {
    func showLoadingView()
    func showLoadingErrorView()
    func showListFilmsView(from: [Info])
    func showFilmsNotFoundView()
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
