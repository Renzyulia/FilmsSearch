//
//  FilmsTableViewDataSource.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

final class FilmsTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    let reuseIdentifier = "Cell"
    private let films: [Info]

    init(films: [Info]) {
        self.films = films
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FilmsCell

        guard let cell = cell else { return UITableViewCell() }
        cell.configureCell(
            title: films[indexPath.row].nameRu,
            genre: FilmGenre(name: films[indexPath.row].genres[0].genre, year: films[indexPath.row].year),
            iconUrl: films[indexPath.row].posterUrlPreview
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
}
