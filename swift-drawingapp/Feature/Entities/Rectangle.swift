//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

struct Rectangle: SelectableShape, StyleApplying {
    var id: UUID
    
    var origin: Point
    var size: Size
    
    var points: [Point] {
        return makePoints(origin: origin, size: size)
    }
    
    var fillColor: Color?
    var lineColor: Color?
    
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
