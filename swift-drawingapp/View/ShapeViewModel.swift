//
//  ShapeViewModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation
import CoreGraphics

struct ShapeViewModel: ShapeViewRepresentable {
    
    private var shape: (any ShapeProtocol)!
    private var scaleFactor: ScaleFactor2D!
     
   mutating  func setShape(_ shape: any ShapeProtocol, scaleFactor: ScaleFactor2D) {
        self.shape = shape
        self.scaleFactor = scaleFactor
    }
    
    var cgPoints: [CGPoint] {
        return shape.points
            .map { $0 * scaleFactor }
    }
    
    var cgFillColor: CGColor? {
        return (shape as? StyleApplying)?.fillColor?.cgColor
    }
    
    var cgLineColor: CGColor? {
        return (shape as? StyleApplying)?.lineColor?.cgColor
    }
    
}

struct ScaleFactor2D {
    var widthFactor: Double
    var heightFactor: Double
}

fileprivate extension Point {
    static func * (origin: Point, scaleFactor: ScaleFactor2D) -> CGPoint {
        var new = origin
        new.x *= scaleFactor.widthFactor
        new.y *= scaleFactor.heightFactor
        return CGPoint(x: new.x, y: new.y)
    }
}
