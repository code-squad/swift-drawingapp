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
        return [
            .init(x: origin.x, y: origin.y),
            .init(x: origin.x+size.width, y: origin.y),
            .init(x: origin.x+size.width, y: origin.y+size.height),
            .init(x: origin.x, y: origin.y+size.height),
            .init(x: origin.x, y: origin.y),
        ]
    }
}

class StyledRectangle: Rectangle, StyleApplying {
    var fillColor: Color?
    var lineColor: Color?
}
