//
//  Drawing.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Drawing: Shape, StyleApplying {
    private(set) var points: [Point] = []
    var color: Color?
    var lineColor: Color?
    
    func addPoint(_ point: Point) {
        points.append(point)
    }
}
