//
//  ShapeViewModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation
import CoreGraphics.CGColor

struct ShapeViewModel: Identifiable {
    var id: ObjectIdentifier
    var points: [CGPoint]
    var fillColor: CGColor?
    var lineColor: CGColor?
    
    init(
        shape: Shape,
        points: [CGPoint],
        fillColor: CGColor? = nil,
        lineColor: CGColor? = nil
    ) {
        self.id = ObjectIdentifier(shape)
        self.points = points
        self.fillColor = fillColor
        self.lineColor = lineColor
    }
}
