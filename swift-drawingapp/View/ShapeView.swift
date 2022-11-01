//
//  ShapeView.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import UIKit

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

class ShapeView: UIView {
    
    lazy private var shape = {
        let shape = CAShapeLayer()
        shape.lineJoin = .miter
        shape.lineWidth = 8
        layer.addSublayer(shape)
        return shape
    }()
    
    func updateShape(_ shapeModel: ShapeViewRepresentable) {
        shape.path = nil
        guard let path = makePath(from: shapeModel.cgPoints) else { return }
        shape.path = path.cgPath
        shape.fillColor = shapeModel.cgFillColor
        shape.strokeColor = shapeModel.cgLineColor
    }
    
    private func makePath(from points: [CGPoint]) -> UIBezierPath? {
        guard !points.isEmpty else { return nil }
        let path = UIBezierPath()
        path.move(to: points.first!)
        if points.count >= 2 {
            for point in points[1...] {
                path.addLine(to: point)
            }
        }
        return path
    }
}
