//
//  LoadingErrorView.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

protocol LoadingErrorViewDelegate: AnyObject {
    func didTapOnUpdateButton()
}

final class LoadingErrorView: UIView {
    weak var delegate: LoadingErrorViewDelegate?
    
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
        errorView.image = .errorIcon
        
        addSubview(errorView)
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.heightAnchor.constraint(equalToConstant: 82),
            errorView.widthAnchor.constraint(equalTo: errorView.heightAnchor),
            errorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureUpdateButton() {
        updateButton.addTarget(self, action: #selector(didTapOnUpdateButton), for: .touchUpInside)
        
        addSubview(updateButton)
        
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 117),
            updateButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -117),
            updateButton.topAnchor.constraint(equalTo: errorView.bottomAnchor, constant: 21)
        ])
    }
    
    @objc private func didTapOnUpdateButton() {
        delegate?.didTapOnUpdateButton()
    }
}
