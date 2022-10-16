//
//  ShapeView.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import UIKit

class ShapeView: UIView {
    
    private var shape = {
        let shape = CAShapeLayer()
        shape.lineJoin = .miter
        return shape
    }()
    
    func updatePath(_ viewModel: ShapeViewModel) {
        guard let path = makePath(from: viewModel.points) else { return }
        shape.path = path.cgPath
        shape.fillColor = viewModel.fillColor
        shape.strokeColor = viewModel.lineColor
        layer.addSublayer(shape)
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
        path.close()
        return path
    }
}
