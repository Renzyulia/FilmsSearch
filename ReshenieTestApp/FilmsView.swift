//
//  FilmsView.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

final class FilmsView: UIView {
    private let tableView = UITableView()
    
    private let tableViewDelegate: UITableViewDelegate
    private let tableViewDataSource: UITableViewDataSource
    
    init(tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource) {
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        super.init(frame: .zero)
        
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

struct Genre {
    let name: String
    let year: Int
}

final class FilmsCell: UITableViewCell {
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let genreLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureIconView()
        configureTitleLabel()
        configureGenreLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, genre: Genre, icon: UIImage) {
        iconView.image = icon
        titleLabel.text = title
        genreLabel.text = "\(genre.name)" + " " + "(\(genre.year)"
    }
    
    private func configureIconView() {
        addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            iconView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
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
            titleLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 15),
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
            genreLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 15),
            genreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27)
        ])
    }
}
