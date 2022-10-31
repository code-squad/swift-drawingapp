//
//  Path.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

struct Path: SelectableShape, StyleApplying {
    let id: UUID = UUID()
    
    private(set) var points: [Point] = []
    
    var fillColor: Color?
    var lineColor: Color?
    
    func contains(_ point: Point) -> Bool {
        return false
    }
    
    mutating func addPoint(_ point: Point) {
        points.append(point)
    }
}
