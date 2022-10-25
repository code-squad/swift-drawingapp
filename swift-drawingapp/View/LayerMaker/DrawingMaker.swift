//
//  LineMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import Foundation
import UIKit
import QuartzCore

class DrawingMaker {
    
    private var tempLayer = CAShapeLayer()
    private var bezierPath = UIBezierPath()
    
    init() {}
    
    func resetTempData() {
        tempLayer = CAShapeLayer()
        bezierPath = UIBezierPath()
    }
    
    func startLineDraw(point: CGPoint) -> CAShapeLayer {
        bezierPath.move(to: point)
        
        tempLayer.lineWidth = 4
        tempLayer.fillColor = UIColor.clear.cgColor
        
        return tempLayer
    }
    
    func addLinePath(to point: CGPoint) {
        bezierPath.addLine(to: CGPoint(x: point.x, y: point.y))
        tempLayer.path = bezierPath.cgPath
    }
    
    func endLineDraw() {
        resetTempData()
    }
}
