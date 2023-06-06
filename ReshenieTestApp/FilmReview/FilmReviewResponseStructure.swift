//
//  ResponseStructure.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 03.06.2023.
//

import UIKit

struct FilmDetails: Decodable {
    let nameRu: String?
    let nameEn: String?
    let posterUrl: URL
    let year: Int
    let description: String?
    let countries: [Countries]
    let genres: [ListGenres]
}

struct Countries: Decodable {
    let country: String
}

struct ListGenres: Decodable {
    let genre: String
}
