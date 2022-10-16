//
//  Drawing.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Drawing: Shape {
    
    func addPoint(_ point: Point) {
        points.append(point)
    }
}

class StyledDrawing: Drawing, StyleApplying {
    var color: Color?
    var lineColor: Color?
}
