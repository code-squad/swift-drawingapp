//
//  DrawingFactory.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/21.
//

import Foundation
import CoreGraphics

protocol DrawingFactoryProtocol {
    func makeSquare(rect: CGRect) -> Square
    func startLinePoint(point: CGPoint) -> Line
    func updateLinePoints(point: CGPoint)
    func endLinePoints() -> Line
}

class DrawingFactory: DrawingFactoryProtocol {
    
    let squareFactory: SquareFactoryProtocol
    let lineFactory: LineFactoryProtocol
    
    init(
        squareFactory: SquareFactoryProtocol,
        lineFactory: LineFactoryProtocol
    ) {
        self.squareFactory = squareFactory
        self.lineFactory = lineFactory
    }
    
    func makeSquare(rect: CGRect) -> Square {
        return squareFactory.makeSquare(rect: rect)
    }
    
    func startLinePoint(point: CGPoint) -> Line {
        return lineFactory.startLine(point: point)
    }
    
    func updateLinePoints(point: CGPoint) {
        lineFactory.moveLine(to: point)
    }
    
    func endLinePoints() -> Line {
        return lineFactory.endLine()
    }
}
