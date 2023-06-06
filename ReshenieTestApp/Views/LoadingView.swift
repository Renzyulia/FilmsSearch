//
//  LoadingView.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

final class LoadingView: UIView {
    private let loadingView = RemoteImageView()
    
    init() {
        super.init(frame: .zero)
        
        configureLoadingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview != nil {
            loadingView.startRotation()
        }
    }
        
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
            
        if superview == nil {
            loadingView.stopRotation()
        }
    }
    
    private func configureLoadingView() {
        loadingView.image = .loadingIcon
        loadingView.tintColor = .black
        
        addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.widthAnchor.constraint(equalToConstant: 45),
            loadingView.heightAnchor.constraint(equalTo: loadingView.widthAnchor),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
