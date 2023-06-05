//
//  FilmSearchRequestStructure.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 05.06.2023.
//

import UIKit

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
