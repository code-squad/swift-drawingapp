//
//  SquareMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/14.
//

import Foundation
import CoreGraphics
import UIKit

class SquareLayerMaker {
    
    init() {
        
    }
    
    func makeSquare(points: [CGPoint]) -> CAShapeLayer {
        let path = UIBezierPath()
        
        for (i, point) in points.enumerated() {
            // 분기를 없앨 수 있는 방법은?
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.randomSystemColor().cgColor
        
        return shapeLayer
    }
}
