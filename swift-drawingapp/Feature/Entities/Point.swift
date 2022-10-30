//
//  Point.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

struct Point: Equatable, Codable {
    var x: Double
    var y: Double
}

extension Point {
    static func random(in size: Size) -> Point {
        return Point(
            x: Double.random(in: 0...size.width),
            y: Double.random(in: 0...size.height)
        )
    }
}
