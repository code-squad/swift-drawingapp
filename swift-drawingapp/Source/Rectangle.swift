//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Rectangle: StyledShape {
    var origin: Point
    var size: Size
    
    var color: Color?
    var lineColor: Color?
    
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
}
