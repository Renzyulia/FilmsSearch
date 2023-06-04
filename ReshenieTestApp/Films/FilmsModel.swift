//
//  FilmsModel.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

final class FilmsModel {
    weak var delegate: FilmsModelDelegate?
    private let apiKey = "fb5368f8-d311-48d9-aadf-c3bd71bda8c5"
    private let requestURL = "https://kinopoiskapiunofficial.tech/api/v2.2/films/premieres?year=2023&month=JUNE"
    
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
            let responseModel = try jsonDecoder.decode(Model.self, from: data)
            
            DispatchQueue.main.async {
                self?.delegate?.showFilmsView(from: responseModel.items)
            }
          } catch {
              DispatchQueue.main.async {
                  self?.delegate?.showLoadingErrorView()
              }
            }
        }).resume()
    }
}

protocol FilmsModelDelegate: AnyObject {
    func showLoadingView()
    func showFilmsView(from data: [Info])
    func showLoadingErrorView()
    func showFilmReviewView(id: Int)
    func showSearchView()
}
