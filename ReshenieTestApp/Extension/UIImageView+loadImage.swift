//
//  UIImageView+loadImage.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

extension UIImageView {
    func loadImage(with url: URL) {
        ImageManager.shared.loadImage(url: url) { [weak self] image in
            self?.image = image
        }
    }
}
