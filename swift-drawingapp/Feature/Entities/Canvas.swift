//
//  Canvas.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

struct Canvas {
    private(set) var size: Size
    private(set) var shapes: [any ShapeProtocol] = []
    
    @discardableResult
    mutating func addShape(_ shape: any ShapeProtocol) -> Bool {
        guard shape.canAdd(to: size) else { return false }
        shapes.append(shape)
        return true
    }

    func findShape(at point: Point) -> (any SelectableShape)? {
        return shapes
            .compactMap { $0 as? any SelectableShape }
            .last { $0.contains(point) }
    }
}
