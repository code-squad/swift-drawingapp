//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Rectangle: StyledShape, Selectable {
    
    var origin: Point
    var size: Size
    
    var color: Color?
    var lineColor: Color?
    
    var isSelected: Bool = false
    
    private var canvas: Canvas?
    
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
    
    func setCanvas(_ canvas: Canvas) {
        self.canvas = canvas
    }
    
    func contains(_ point: Point) -> Bool {
        return origin.x...origin.x+size.width ~= point.x &&
        origin.y...origin.y+size.height ~= point.y
    }
}
