//
//  LineMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import Foundation
import UIKit
import QuartzCore

class LineMaker {
    
    private var tempLayer = CAShapeLayer()
    private var bezierPath = UIBezierPath()
    
    init() {}
    
    func getTempLayer() -> CAShapeLayer {
        return tempLayer
    }
    
    func getTempPath() -> UIBezierPath {
        return bezierPath
    }
    
    func resetTempData() {
        tempLayer = CAShapeLayer()
        bezierPath = UIBezierPath()
    }
    
    func startLineDraw(point: CGPoint) {
        resetTempData()
        
        bezierPath.move(to: point)
        
        tempLayer.lineWidth = 4
        tempLayer.fillColor = UIColor.clear.cgColor
        tempLayer.strokeColor = UIColor.clear.randomSystemColor().cgColor
    }
    
    func addLinePath(to point: CGPoint) {
        bezierPath.addLine(to: CGPoint(x: point.x, y: point.y))
        tempLayer.path = bezierPath.cgPath
    }
}
