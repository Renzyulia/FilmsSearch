//
//  FloatingPoint+transformDegreesToRadians.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 02.06.2023.
//

import UIKit

extension FloatingPoint {
    var degreesToRadians: Self {
        return self * .pi / 180
    }
}
