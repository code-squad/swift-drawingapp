//
//  UIColor+random.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import UIKit

extension DrawingColor {

    var uiColor: UIColor {
        switch self {
        case .blue:
            return .systemBlue
        case .brown:
            return .systemBrown
        case .cyan:
            return .systemCyan
        case .green:
            return .systemGreen
        case .indigo:
            return .systemIndigo
        case .mint:
            return .systemMint
        case .orange:
            return .systemOrange
        case .pink:
            return .systemPink
        case .purple:
            return .systemPurple
        case .teal:
            return .systemTeal
        case .yellow:
            return .systemYellow
        }
    }
}
