//
//  Drawing.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Drawing: StyledShape {
    private(set) var points: [Point] = []
    var color: Color?
    var lineColor: Color?
    
    private var canvas: Canvas?
    
    @discardableResult
    func addPoint(_ point: Point) -> Bool {
        guard canvas?.size.contains(point) ?? true else { return false }
        points.append(point)
        return true
    }
    
    func setCanvas(_ canvas: Canvas) {
        self.canvas = canvas
    }
}
