//
//  StructRequest.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

struct Films: Decodable {
    let total: Int
    let items: [FilmInfo]
}

struct FilmInfo: Decodable {
    let kinopoiskId: Int
    let nameRu: String
    let year: Int
    let posterUrlPreview: URL
    let genres: [Genre]
}

struct Genre: Decodable {
    let genre: String
}
