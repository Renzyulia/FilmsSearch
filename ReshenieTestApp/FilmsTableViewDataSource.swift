//
//  FilmsTableViewDataSource.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

struct Films {
    let title: String
    let genre: String
    let year: Int
    let image: UIImage
}

final class FilmsTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
//    private let countFilms: Int
//    private let films: [Films]
    let reuseIdentifier = "Cell"

//    init(countFilms: Int, films: [Films]) {
//        self.countFilms = countFilms
//        self.films = films
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return countFilms
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FilmsCell
//
//        guard let cell = cell else { return UITableViewCell() }
//        cell.configureCell(
//            title: films[indexPath.item].title,
//            genre: Genre(name: films[indexPath.item].genre, year: films[indexPath.item].year),
//            icon: films[indexPath.item].image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
}
