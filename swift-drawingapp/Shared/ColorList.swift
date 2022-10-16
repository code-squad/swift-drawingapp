//
//  ColorList.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import UIKit.UIColor

extension Color {
    static let systemList: [Color] = [
        UIColor.systemBlue,
        .systemCyan,
        .systemMint,
        .systemPink,
        .systemTeal,
        .systemBrown,
        .systemGreen,
        .systemOrange,
        .systemYellow,
        .systemIndigo,
        .systemPurple
    ]
        .map {
            let (r, g, b, a) = $0.rgba
            return Color(red: r, green: g, blue: b)
        }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
