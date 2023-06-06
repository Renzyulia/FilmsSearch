//
//  FilmView.swift
//  ReshenieTestApp
//
//  Created by d.kelt on 06.06.2023.
//

import UIKit

final class FilmView: UIView {
    private let posterView = RemoteImageView()
    private let titleLabel = UILabel()
    private let genreLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        configureIconView()
        configureTitleLabel()
        configureGenreLabel()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, genre: FilmGenre, posterUrl: URL) {
        titleLabel.text = title
        genreLabel.text = "\(genre.name) (\(genre.year))"
        posterView.loadImage(with: posterUrl)
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.masksToBounds = false
        layer.cornerRadius = 15
    }
    
    private func configureIconView() {
        posterView.contentMode = .scaleAspectFill
        posterView.layer.masksToBounds = true
        posterView.layer.cornerRadius = 5
        
        addSubview(posterView)
        
        posterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterView.widthAnchor.constraint(equalToConstant: 40),
            posterView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            posterView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            posterView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.font = UIFont.specialFont(size: 16, style: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            titleLabel.leftAnchor.constraint(equalTo: posterView.rightAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50)
        ])
    }
    
    private func configureGenreLabel() {
        genreLabel.font = UIFont.specialFont(size: 14, style: .medium)
        genreLabel.textColor = .gray
        genreLabel.numberOfLines = 1
        
        addSubview(genreLabel)
        
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            genreLabel.leftAnchor.constraint(equalTo: posterView.rightAnchor, constant: 15),
            genreLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50)
        ])
    }
}
