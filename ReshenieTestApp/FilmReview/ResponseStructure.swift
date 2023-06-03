//
//  ResponseStructure.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 03.06.2023.
//

import UIKit

struct Review: Decodable {
    let nameRu: String
    let posterUrl: URL
    let year: Int
    let description: String
    let countries: [Country]
    let genres: [ListGenres]
}

struct Country: Decodable {
    let country: String
}

struct ListGenres: Decodable {
    let genre: String
}
