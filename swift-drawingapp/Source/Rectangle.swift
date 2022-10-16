//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Rectangle: Shape, Selectable {
    
    private(set) var origin: Point
    private(set) var size: Size
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
        
        super.init()
        
        points = makePoints(origin: origin, size: size)
    }
    
    func contains(_ point: Point) -> Bool {
        return origin.x...origin.x+size.width ~= point.x &&
        origin.y...origin.y+size.height ~= point.y
    }
    
    private func makePoints(origin: Point, size: Size) -> [Point] {
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
}

class StyledRectangle: Rectangle, StyleApplying {
    var color: Color?
    var lineColor: Color?
}
