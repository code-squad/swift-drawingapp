//
//  Canvas.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

typealias StyledShape = Shape & StyleApplying
typealias SelectableStyledShape = Selectable & StyledShape

class Canvas {
    let size: Size
    private(set) var shapes: [StyledShape] = []
    
    init(size: Size) {
        self.size = size
    }
    
    @discardableResult
    func addShape(_ shape: StyledShape) -> Bool {
        for point in shape.points {
            guard size.contains(point) else { return false }
        }
        shapes.append(shape)
        shape.setCanvas(self)
        return true
    }
    
    func findShape(at point: Point) -> SelectableStyledShape? {
        let selectedShape = shapes
            .compactMap { $0 as? SelectableStyledShape }
            .first { $0.contains(point) }
        return selectedShape
    }
}
