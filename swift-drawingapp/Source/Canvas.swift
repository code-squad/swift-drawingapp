//
//  Canvas.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Canvas {
    private var size: Size
    private(set) var shapes: [Shape] = []
    
    init(size: Size) {
        self.size = size
    }
    
    func addShape(_ shape: Shape) -> Bool {
        for point in shape.points {
            guard
                0...size.width ~= point.x,
                0...size.height ~= point.y
            else { return false }
        }
        shapes.append(shape)
        return true
    }
}


