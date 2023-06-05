//
//  UnfoundedView.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 04.06.2023.
//

import UIKit

final class FilmsNotFoundView: UIView {
    private let notFoundLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        configureNotFoundLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNotFoundLabel() {
        notFoundLabel.text = "Не найдено"
        notFoundLabel.textAlignment = .center
        notFoundLabel.textColor = .white
        notFoundLabel.font = UIFont.specialFont(size: 16, style: .regular)
        notFoundLabel.backgroundColor = UIColor(named: "CustomColor")
        notFoundLabel.layer.masksToBounds = true
        notFoundLabel.layer.cornerRadius = 20
        
        addSubview(notFoundLabel)
        
        notFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notFoundLabel.heightAnchor.constraint(equalToConstant: 40),
            notFoundLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            notFoundLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            notFoundLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 116),
            notFoundLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -116)
        ])
    }
}
