//
//  FilmsView.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

protocol ConfiguringDataSource: UITableViewDataSource, UITableViewDelegate {
    func didAttach(to: UITableView)
}

final class FilmsView: UIView {
    private let tableView = UITableView()
    private let dataSource: ConfiguringDataSource
    
    init(dataSource: ConfiguringDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.separatorColor = .clear
        dataSource.didAttach(to: tableView)
        
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

struct FilmGenre {
    let name: String
    let year: Int
}
