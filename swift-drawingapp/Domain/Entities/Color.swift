//
//  Color.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/29.
//

import Foundation

enum Color: CaseIterable, Codable {
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

    static var randomColor: Self {
        Color.allCases.randomElement() ?? .blue
    }
}
