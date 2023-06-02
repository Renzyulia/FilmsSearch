//
//  StructRequest.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

struct Model: Decodable {
    let total: Int
    let items: [Info]
}

struct Info: Decodable {
    let kinopoiskId: Int
    let nameRu: String
    let year: Int
    let posterUrlPreview: URL
    let genres: [Genre]
}

struct Genre: Decodable {
    let genre: String
}
