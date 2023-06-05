//
//  DataManager.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 05.06.2023.
//

import UIKit

enum Result<T: Decodable> {
    case success(T)
    case failure
}

final class DataManager {
    static let shared = DataManager()
    
    private let apiKey = "fb5368f8-d311-48d9-aadf-c3bd71bda8c5"
    private let host = "https://kinopoiskapiunofficial.tech/"
    
    private init() {}
    
    func loadData<T: Decodable>(path: String, completion: @escaping (Result<T>) -> Void) {
        var request = URLRequest(url: URL(string: host + path)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
          do {
            guard let data = data, error == nil else { return }
            let jsonDecoder = JSONDecoder()
            let responseModel = try jsonDecoder.decode(T.self, from: data)
            
            DispatchQueue.main.async {
                completion(.success(responseModel))
            }
          } catch {
              DispatchQueue.main.async {
                  completion(.failure)
              }
            }
        }).resume()
    }
}
