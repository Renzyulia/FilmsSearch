//
//  UIFont+CustomFont.swift
//  ReshenieTestApp
//
//  Created by Yulia Ignateva on 01.06.2023.
//

import UIKit

extension UIFont {
    static func specialFont(size: CGFloat, style: Style) -> UIFont {
        switch style {
        case .regular: return UIFont(name: "Roboto-Regular", size: size)!
        case .medium: return UIFont(name: "Roboto-Medium", size: size)!
        case .bold: return UIFont(name: "Roboto-Black", size: size)!
        }
    }
}

enum Style {
    case regular
    case medium
    case bold
}
