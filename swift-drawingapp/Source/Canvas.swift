//
//  Canvas.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

typealias StyledShape = Shape & StyleApplying

class Canvas {
    let size: Size
    private(set) var shapes: [StyledShape] = []
    
    init(size: Size) {
        self.size = size
    }
    
    func addShape(_ shape: StyledShape) -> Bool {
        for point in shape.points {
            guard size.contains(point) else { return false }
        }
        shapes.append(shape)
        shape.setCanvas(self)
        return true
    }
    
    @discardableResult
    func select(at point: Point) -> (Selectable & StyledShape)? {
        let selectedShape = shapes
            .compactMap { $0 as? Selectable & StyledShape }
            .first { $0.contains(point) }
        selectedShape?.isSelected = true
        return selectedShape
    }
}
