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
        .map { Color(uiColor: $0) }
    
    static let systemRed: Color = .init(uiColor: .systemRed)
    
    static let yellow: Color = .init(uiColor: .systemYellow)
    static let blue: Color = .init(uiColor: .systemBlue)
    
    init(uiColor: UIColor) {
        let (r, g, b, _) = uiColor.rgba
        self.init(red: r, green: g, blue: b)
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
