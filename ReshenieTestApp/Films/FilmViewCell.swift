//
//  FilmViewCell.swift
//  ReshenieTestApp
//
//  Created by d.kelt on 06.06.2023.
//

import UIKit

final class FilmViewCell: UITableViewCell {
    private lazy var filmView = FilmView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, genre: FilmGenre, posterUrl: URL) {
        filmView.configure(title: title, genre: genre, posterUrl: posterUrl)
    }
    
    private func configureSubviews() {
        backgroundColor = .none
        selectionStyle = .none
        
        contentView.addSubview(filmView)
        
        filmView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filmView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            filmView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            filmView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            filmView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
}

