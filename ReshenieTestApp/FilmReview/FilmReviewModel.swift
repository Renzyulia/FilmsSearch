//
//  FilmReviewModel.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 03.06.2023.
//

import UIKit

final class FilmReviewModel {
    weak var delegate: FilmReviewModelDelegate?
    
    private let filmID: Int
    private let apiKey = "fb5368f8-d311-48d9-aadf-c3bd71bda8c5"
    private var requestURL = "https://kinopoiskapiunofficial.tech/api/v2.2/films/"
    
    init(filmID: Int) {
        self.filmID = filmID
        requestURL = "\(requestURL) + \(filmID)"
    }
    
    func viewDidLoad() {
        delegate?.showLoadingView()
        getFilmData()
    }
    
    private func getFilmData() {
        var request = URLRequest(url: URL(string: requestURL)!)
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
            let responseModel = try jsonDecoder.decode(Review.self, from: data)
            
            DispatchQueue.main.async {
                var listGenres = [String]()
                var countries = [String]()
                
                for genre in responseModel.genres {
                    listGenres.append(genre.genre)
                }
                
                for country in responseModel.countries {
                    countries.append(country.country)
                }
                
                self?.delegate?.showReviewView(
                    posterUrl: responseModel.posterUrl,
                    title: responseModel.nameRu,
                    review: responseModel.description,
                    genres: listGenres,
                    countries: countries,
                    year: responseModel.year)
            }
          } catch {
              DispatchQueue.main.async {
                  self?.delegate?.showLoadingErrorView()
              }
            }
        }).resume()
    }
}

protocol FilmReviewModelDelegate: AnyObject {
    func showLoadingView()
    func showReviewView(posterUrl: URL, title: String, review: String, genres: [String], countries: [String], year: Int)
    func showLoadingErrorView()
}
