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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updatePath(_ shapeRepresent: ShapeViewRepresentable) {
        guard let path = makePath(from: shapeRepresent.points) else { return }
        shape.path = path.cgPath
        shape.fillColor = shapeRepresent.color
        shape.strokeColor = shapeRepresent.lineColor
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
