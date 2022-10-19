//
//  ColorSet.swift
//  swift-drawingapp
//
//  Created by 윤태민(Yun, Taemin) on 2022/10/18.
//

import UIKit

struct ColorSet {
    static var randomColor: UIColor {
        let systemColors: [UIColor] = [
            UIColor.systemGreen,
            UIColor.systemBlue,
            UIColor.systemOrange,
            UIColor.systemYellow,
            UIColor.systemPink,
            UIColor.systemPurple,
            UIColor.systemTeal,
            UIColor.systemIndigo,
            UIColor.systemBrown,
            UIColor.systemMint,
            UIColor.systemCyan,
        ]
        
        return systemColors[Int.random(in: 0 ..< systemColors.count)]
    }
}
