//
//  UIColor+RandomSystemColor.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import UIKit

extension UIColor {

    static let systemColorsWithoutRed: [UIColor] = [.systemGray, .systemMint, .systemCyan, .systemBlue, .systemPink, .systemTeal, .systemBrown, .systemIndigo, .systemOrange, .systemGreen, .systemYellow]

    static var randomColor: UIColor {
        return UIColor.systemColorsWithoutRed.randomElement() ?? .systemGray5
    }
}
