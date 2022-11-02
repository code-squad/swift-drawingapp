//
//  ShapeViewRepresentable.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/11/02.
//

import Foundation

protocol ShapeViewRepresentable {
    var cgPoints: [CGPoint] { get }
    var cgFillColor: CGColor? { get }
    var cgLineColor: CGColor? { get }
}

struct AnyShapeViewModel: ShapeViewRepresentable {
    var cgPoints: [CGPoint]
    var cgFillColor: CGColor?
    var cgLineColor: CGColor?
    
    init(_ shapeViewModel: ShapeViewRepresentable) {
        self.cgPoints = shapeViewModel.cgPoints
        self.cgFillColor = shapeViewModel.cgFillColor
        self.cgLineColor = shapeViewModel.cgLineColor
    }
}
