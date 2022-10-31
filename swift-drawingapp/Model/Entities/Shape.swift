//
//  Shape.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/30.
//

import Foundation

struct Shape: ShapeProtocol, StyleApplying {
    let id: UUID = UUID()
    
    private(set) var points: [Point] = []
    
    var fillColor: Color?
    var lineColor: Color?
}
