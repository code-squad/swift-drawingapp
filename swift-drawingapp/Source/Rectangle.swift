//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Rectangle: Shape, StyleApplying {
    var origin: Point
    var size: Size
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    var points: [Point] {
        var points = [Point]()
        points.append(origin)
        var nextPoint = origin
        nextPoint.x += size.width
        points.append(nextPoint)
        nextPoint.y += size.height
        points.append(nextPoint)
        nextPoint.x -= size.width
        points.append(nextPoint)
        points.append(origin)
        return points
    }
    
    var color: Color?
    var lineColor: Color?
}
