//
//  UIColor+System.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import UIKit

extension UIColor {
    static func system(_ color: Color) -> UIColor {
        switch color {
        case .blue:   return .systemBlue
        case .brown:  return .systemBrown
        case .cyan:   return .systemCyan
        case .green:  return .systemGreen
        case .indigo: return .systemIndigo
        case .mint:   return .systemMint
        case .orange: return .systemOrange
        case .pink:   return .systemPink
        case .purple: return .systemPurple
        case .teal:   return .systemTeal
        case .yellow: return .systemYellow
        }
    }
}
