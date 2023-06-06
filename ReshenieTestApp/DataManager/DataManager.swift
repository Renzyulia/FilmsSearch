//
//  DataManager.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 05.06.2023.
//

import UIKit

final class DataManager {
    
    enum LoadingError: Error {
        case missingDataError
    }
    
    static let shared = DataManager()
    
    private let apiKey = "fb5368f8-d311-48d9-aadf-c3bd71bda8c5"
    private let host = URL(string: "https://kinopoiskapiunofficial.tech/api")!
    
    private init() {}
    
    func loadData<Model: Decodable>(path: String, arguments: [String: String]? = nil, queue: DispatchQueue = .main, completion: @escaping (Result<Model, Error>) -> Void) {
        var url = host.appending(path: path)
        if let arguments = arguments {
            let queryItems = arguments.map { item in
                return URLQueryItem(name: item.key, value: item.value)
            }
            url = url.appending(queryItems: queryItems)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let result: Result<Model, Error>
            if let error = error {
                result = .failure(error)
            } else if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(Model.self, from: data)
                    result = .success(responseModel)
                } catch {
                    result = .failure(error)
                }
            } else {
                result = .failure(LoadingError.missingDataError)
            }
            queue.async {
                completion(result)
            }
        }.resume()
    }
}
