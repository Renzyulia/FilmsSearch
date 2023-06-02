//
//  LoadingErrorView.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

final class LoadingErrorView: UIView {
    private let errorView = UIImageView()
    private let updateButton = UpdateButton()
    
    init() {
        super.init(frame: .zero)
        
        configureErrorView()
        configureUpdateButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureErrorView() {
        errorView.image = UIImage(named: "ErrorIcon")
        
        addSubview(errorView)
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.heightAnchor.constraint(equalToConstant: 82),
            errorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureUpdateButton() {
        addSubview(updateButton)
        
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 117),
            updateButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -117),
            updateButton.topAnchor.constraint(equalTo: errorView.bottomAnchor, constant: 21)
        ])
    }
}

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
        backgroundColor = UIColor(named: "CustomColor")
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
