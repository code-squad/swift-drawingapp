//
//  UIColor+Extensions.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/25.
//

import UIKit

extension UIColor {
    
    var toString: String {
        switch self {
        case .systemRed:
            return "systemRed"
            
        case .systemBlue:
            return "systemBlue"
            
        case .systemCyan:
            return "systemCyan"
            
        case .systemMint:
            return "systemMint"
            
        case .systemGray:
            return "systemGray"
            
        case .systemTeal:
            return "systemTeal"
            
        case .systemBrown:
            return "systemBrown"
            
        case .systemOrange:
            return "systemOrange"
            
        case .systemPink:
            return "systemPink"
            
        case .systemYellow:
            return "systemYellow"
            
        case .systemGreen:
            return "systemGreen"
            
        default:
            return "clear"
        }
    }
}
