//
//  LoadingView.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

final class LoadingView: UIView {
    private let loadingView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        
        configureLoadingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLoadingView() {
        loadingView.image = UIImage(named: "LoadingIcon")
        loadingView.tintColor = UIColor(named: "CustomColor")
        loadingView.transform = loadingView.transform.rotated(by: 1.2.degreesToRadians)
        
        addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.widthAnchor.constraint(equalToConstant: 45),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
