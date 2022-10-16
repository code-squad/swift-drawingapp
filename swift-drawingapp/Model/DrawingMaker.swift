//
//  DrawingMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import UIKit

class DrawingMaker {
    
    let lineMaker = LineMaker()
    let squareMaker = SquareMaker()
    
    init() {}
    
    func getSquareLayer(rect: CGRect) -> CAShapeLayer {
        let square = squareMaker.getSquare(rect: rect)
        return square
    }
    
    func startLineDrawing(point: CGPoint) {
        lineMaker.startLineDraw(point: point)
    }
        
    func updateLinePath(point: CGPoint) {
        lineMaker.addLinePath(to: point)
    }
    
    func getlineLayer() -> CAShapeLayer {
        return lineMaker.getTempLayer()
    }
}
