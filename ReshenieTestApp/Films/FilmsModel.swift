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
        
//        var request = URLRequest(url: URL(string: requestURL)!)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
//
//        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error -> Void in
//          do {
//            guard let self = self else { return }
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    self.delegate?.showLoadingErrorView()
//                }
//                return
//            }
//
//            let jsonDecoder = JSONDecoder()
//            let responseModel = try jsonDecoder.decode(Model.self, from: data)
//
//            DispatchQueue.main.async {
//                let listOfFilms = self.sortListOfFilms(films: responseModel.items)
//                self.delegate?.showFilmsView(from: listOfFilms)
//            }
//          } catch {
//              DispatchQueue.main.async {
//                  guard let self = self else { return }
//                  self.delegate?.showLoadingErrorView()
//              }
//            }
//        }).resume()
    }
    
    private func sortListOfFilms(films: [FilmInfo]) -> [FilmInfo] {
        films.sorted(by: { (firstFilm: FilmInfo, secondFilm: FilmInfo) -> Bool in
            return firstFilm.year < secondFilm.year
        })
    }
}
