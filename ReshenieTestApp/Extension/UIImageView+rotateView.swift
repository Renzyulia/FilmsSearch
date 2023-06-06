//
//  FloatingPoint+transformDegreesToRadians.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

extension UIImageView {
    private var rotationAnimationKey: String {
        return "rotationAnimation"
    }
    
    func startRotation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: rotationAnimationKey)
    }
    
    func stopRotation() {
        layer.removeAnimation(forKey: rotationAnimationKey)
    }
}
