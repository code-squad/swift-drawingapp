//
//  DrawingMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import UIKit

class DrawingLayerMaker {
    
    let lineMaker = LineLayerMaker()
    let squareMaker = SquareLayerMaker()
    
    init() {}
    
    func getSquareLayer(points: [CGPoint]) -> CAShapeLayer {
        let square = squareMaker.makeSquare(points: points)
        return square
    }
    
    func startLineDrawing(point: CGPoint) -> CAShapeLayer {
        lineMaker.startLineDraw(point: point)
        return lineMaker.getTempLayer()
    }
        
    func updateLinePath(point: CGPoint) {
        lineMaker.addLinePath(to: point)
    }
    
    func endLineDrawing() {
        lineMaker.endLineDraw()
    }
}
