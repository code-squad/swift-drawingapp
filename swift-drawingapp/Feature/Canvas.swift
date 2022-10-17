//
//  Canvas.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Canvas: ShapeDelegate {
    
    let size: Size
    private(set) var shapes: [Shape] = [] {
        didSet {
            delegate?.shapesWillChange(shapes)
        }
    }
    
    weak var delegate: CanvasDelegate?
    
    init(size: Size) {
        self.size = size
    }
    
    @discardableResult
    func addShape(_ shape: Shape) -> Bool {
        for point in shape.points {
            guard size.contains(point) else { return false }
        }
        shape.delegate = self
        shapes.append(shape)
        return true
    }
    
    func findShape(at point: Point) -> Shape? {
        return shapes
            .compactMap { $0 as? Selectable & Shape }
            .last { $0.contains(point) }
    }
    
    // MARK: - ShapeDelegate
    
    func pointsDidChange(_ points: [Point]) {
        delegate?.shapesWillChange(shapes)
    }
}

protocol CanvasDelegate: AnyObject {
    func shapesWillChange(_ shapes: [Shape])
}
