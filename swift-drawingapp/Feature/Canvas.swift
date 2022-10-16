//
//  Canvas.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Canvas {
    
    let size: Size
    @Published private(set) var shapes: [Shape] = []
    
    init(size: Size) {
        self.size = size
    }
    
    @discardableResult
    func addShape(_ shape: Shape) -> Bool {
        for point in shape.points {
            guard size.contains(point) else { return false }
        }
        shapes.append(shape)
        return true
    }
    
    func findShape(at point: Point) -> Shape? {
        let selectedIndex = shapes
            .compactMap { $0 as? Selectable }
            .firstIndex { $0.contains(point) }
        guard let selectedIndex else { return nil }
        return shapes[selectedIndex]
    }
}
