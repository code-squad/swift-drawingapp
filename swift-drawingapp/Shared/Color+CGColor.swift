//
//  Color+CGColor.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import CoreGraphics.CGColor

extension Color {
    var cgColor: CGColor {
        return .init(red: red, green: green, blue: blue, alpha: 1)
    }
}
