//
//  Point.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/19.
//

import UIKit

struct Point {
    
    let x: Double
    
    let y: Double
    
    static let zero = Point(x: 0, y: 0)
}

extension Point {
    
    var toCGPoint: CGPoint { .init(x: x, y: y) }
}
