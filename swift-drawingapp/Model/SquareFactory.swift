//
//  SquareFactory.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/21.
//

import Foundation
import CoreGraphics

protocol SquareFactoryProtocol {
    func makeSquare(rect: CGRect) -> Square
}

class SquareFactory: SquareFactoryProtocol {
    
    let squareWidth: CGFloat = 100
    let squareHeight: CGFloat = 100
        
    init() {
        
    }
    
    func makeSquare(rect: CGRect) -> Square {
        let points = self.getRectPoints(rect: rect)
        return Square(points: points)
    }

    func getRectPoints(rect: CGRect) -> [CGPoint] {
        let rect = self.getRect(rect: rect)
        
        let leftTop = CGPoint(x: rect.origin.x, y: rect.origin.y)
        let leftBottom = CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height)
        let rightBottom = CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height)
        let rightTop = CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y)
        
        return [leftTop, leftBottom, rightBottom, rightTop, leftTop]
    }
    
    func getRect(rect: CGRect) -> CGRect {
        let possibleRange = possibleStartingPointRange(rect: rect)
        let startingPoint = randomStartingPoint(rangeX: possibleRange.rangeX, rangeY: possibleRange.rangeY)
        return CGRect(x: startingPoint.x, y: startingPoint.y, width: squareWidth, height: squareHeight)
    }
        
    func possibleStartingPointRange(rect: CGRect) -> (rangeX: Range<CGFloat>, rangeY: Range<CGFloat>) {
        let maxX = rect.origin.x + rect.width - squareWidth
        let maxY = rect.origin.y + rect.height - squareHeight
        
        let rangeX = rect.origin.x..<maxX
        let rangeY = rect.origin.x..<maxY
        
        return (rangeX, rangeY)
    }
    
    func randomStartingPoint(rangeX: Range<CGFloat>, rangeY: Range<CGFloat>) -> CGPoint {
        let x = CGFloat.random(in: rangeX)
        let y = CGFloat.random(in: rangeY)
        return CGPoint(x: x, y: y)
    }
}
