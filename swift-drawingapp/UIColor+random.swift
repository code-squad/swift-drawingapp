//
//  UIColor+random.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        let random = Int.random(in: 0...10)

        switch random {
        case 0:
            return .systemBlue
        case 1:
            return .systemBrown
        case 2:
            return .systemCyan
        case 3:
            return .systemGreen
        case 4:
            return .systemIndigo
        case 5:
            return .systemMint
        case 6:
            return .systemOrange
        case 7:
            return .systemPink
        case 8:
            return .systemPurple
        case 9:
            return .systemTeal
        case 10:
            return .systemYellow
        default:
            return .systemBlue
        }
    }
}
