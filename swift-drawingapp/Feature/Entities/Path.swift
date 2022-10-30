//
//  Path.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

struct Path: SelectableShape, StyleApplying {
    private(set) var points: [Point] = []
    
    var fillColor: Color?
    var lineColor: Color?
    
    func contains(_ point: Point) -> Bool {
        return false
    }
    
    mutating func addPoint(_ point: Point) {
        points.append(point)
    }
    
    mutating func addPoints(_ pointStream: AnyAsyncSequence<Point>) async throws {
        for try await point in pointStream {
            addPoint(point)
        }
    }
}
