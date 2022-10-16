//
//  Drawing.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Drawing: Shape {
    
    @discardableResult
    func addPoint(_ point: Point) -> Bool {
        guard canvas?.size.contains(point) ?? true else { return false }
        points.append(point)
        return true
    }
}

class StyledDrawing: Drawing, StyleApplying {
    var color: Color?
    var lineColor: Color?
}
