//
//  DrawingColor.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/25.
//

import Foundation

enum DrawingColor {
    case blue
    case brown
    case cyan
    case green
    case indigo
    case mint
    case orange
    case pink
    case purple
    case teal
    case yellow
}

extension DrawingColor {

    static var random: Self {
        let random = Int.random(in: 0...10)

        switch random {
        case 0:
            return .blue
        case 1:
            return .brown
        case 2:
            return .cyan
        case 3:
            return .green
        case 4:
            return .indigo
        case 5:
            return .mint
        case 6:
            return .orange
        case 7:
            return .pink
        case 8:
            return .purple
        case 9:
            return .teal
        case 10:
            return .yellow
        default:
            return .blue
        }
    }
}
