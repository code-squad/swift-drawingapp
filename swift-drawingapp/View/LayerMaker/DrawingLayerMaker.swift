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
    
    func getSquareLayer(square: Square) -> CAShapeLayer {
        let squareLayer = squareMaker.makeSquare(points: square.points)
        squareLayer.name = "\(square.uuid)"
        return squareLayer
    }
    
    func startLineDrawing(line: Line) -> CAShapeLayer? {
        guard let point = line.points.first else {
            return nil
        }
        let lineLayer = lineMaker.startLineDraw(point: point)
        lineLayer.name = "\(line.uuid)"
        return lineLayer
    }
        
    func updateLinePath(point: CGPoint) {
        lineMaker.addLinePath(to: point)
    }
    
    func endLineDrawing() {
        lineMaker.endLineDraw()
    }
}
