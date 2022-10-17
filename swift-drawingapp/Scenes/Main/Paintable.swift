//
//  Paintable.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation

protocol Paintable: Identifiable {
    var color: Color { get }
    var area: Area { get }
}

enum Color: CaseIterable {
    static var randomColor: Self {
        Color.allCases.randomElement() ?? .blue
    }

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

struct Area {
    struct Origin {
        let x: Double
        let y: Double
    }
    struct Size {
        let width: Double
        let height: Double
    }
    let origin: Origin
    let size: Size
}
