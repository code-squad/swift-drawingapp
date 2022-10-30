//
//  CGColor+Extensions.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/25.
//

import UIKit

extension CGColor {
    
    var toString: String {
        switch self {
        case UIColor.systemRed.cgColor:
            return "systemRed.cgColor"
            
        case UIColor.systemBlue.cgColor:
            return "systemBlue.cgColor"
            
        case UIColor.systemCyan.cgColor:
            return "systemCyan.cgColor"
            
        case UIColor.systemMint.cgColor:
            return "systemMint.cgColor"
            
        case UIColor.systemGray.cgColor:
            return "systemGray.cgColor"
            
        case UIColor.systemTeal.cgColor:
            return "systemTeal.cgColor"
            
        case UIColor.systemBrown.cgColor:
            return "systemBrown.cgColor"
            
        case UIColor.systemOrange.cgColor:
            return "systemOrange.cgColor"
            
        case UIColor.systemPink.cgColor:
            return "systemPink.cgColor"
            
        case UIColor.systemYellow.cgColor:
            return "systemYellow.cgColor"
            
        case UIColor.systemGreen.cgColor:
            return "systemGreen.cgColor"
            
        default:
            return "clear.cgColor"
        }
    }
}
