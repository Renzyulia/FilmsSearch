//
//  FilmsTableViewDataSource.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

protocol FilmsTableViewDataSourceDelegate: AnyObject {
    func didTapFilmAt(id: Int)
}

final class FilmsTableViewDataSource: NSObject, ConfiguringDataSource {
    weak var delegate: FilmsTableViewDataSourceDelegate?
    
    private let reuseIdentifier = "Cell"
    private let films: [FilmInfo]

    init(films: [FilmInfo]) {
        self.films = films
    }
    
    func didAttach(to tableView: UITableView) {
        tableView.register(FilmViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FilmViewCell
        guard let cell = cell else { return UITableViewCell() }
        let film = films[indexPath.row]
        cell.configure(
            title: film.nameRu,
            genre: FilmGenre(name: film.genres[0].genre.lowercased().capitalized, year: film.year),
            posterUrl: film.posterUrlPreview
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = films[indexPath.row].kinopoiskId
        delegate?.didTapFilmAt(id: id)
    }
}
