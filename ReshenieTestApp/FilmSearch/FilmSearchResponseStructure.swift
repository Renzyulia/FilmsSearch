//
//  FilmSearchRequestStructure.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 05.06.2023.
//

import UIKit

struct FilmSearchResult: Decodable {
    let films: [Film]
}

struct Film: Decodable {
    let filmId: Int
    let nameRu: String?
    let nameEn: String?
    let year: String
    let genres: [Genre]
    let posterUrlPreview: URL
}
