//
//  UIImageView+loadImage.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

final class RemoteImageView: UIImageView {
    
    private var currentUrl: URL?
    
    func loadImage(with url: URL) {
        currentUrl = url
        ImageManager.shared.loadImage(url: url) { [weak self] image in
            guard let self = self else { return }
            if self.currentUrl == url {
                self.image = image
            }
        }
    }
}
