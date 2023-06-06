//
//  UpdateButton.swift
//  ReshenieTestApp
//
//  Created by d.kelt on 06.06.2023.
//

import UIKit

final class UpdateButton: UIControl {
    private let updateLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        configureUpdateButton()
        configureUpdateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUpdateButton() {
        backgroundColor = .customColor
        layer.masksToBounds = true
        layer.cornerRadius = 24
        contentHorizontalAlignment = .center
    }
    
    private func configureUpdateLabel() {
        updateLabel.text = "Повторить"
        updateLabel.font = UIFont.specialFont(size: 14, style: .medium)
        updateLabel.textColor = .white
        updateLabel.textAlignment = .center
        
        addSubview(updateLabel)
        
        updateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            updateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 27),
            updateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -27),
            updateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
