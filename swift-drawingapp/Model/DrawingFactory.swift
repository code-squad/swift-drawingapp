//
//  DrawingFactory.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/21.
//

import Foundation
import CoreGraphics

class DrawingFactory {
    
    let squareFactory = SquareFactory()
    let lineFactory = LineFactory()
    
    init() {}
    
    func makeSquare(rect: CGRect) -> Square {
        return squareFactory.makeSquare(rect: rect)
    }
    
    func startLinePoint(point: CGPoint) {
        lineFactory.startLine(point: point)
    }
    
    func updateLinePoints(point: CGPoint) {
        lineFactory.moveLine(to: point)
    }
    
    func endLinePoints() -> Line {
        return lineFactory.endLine()
    }
}
