//
//  SquareMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/14.
//

import Foundation
import CoreGraphics
import UIKit

class SquareMaker {
    
    let squareWidth: CGFloat = 100
    let squareHeight: CGFloat = 100
        
    init() {
        
    }
    
    func getSquare(rect: CGRect) -> CAShapeLayer {
        let rect = self.getRect(rect: rect)
        
        let leftTop = CGPoint(x: rect.origin.x, y: rect.origin.y)
        let leftBottom = CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height)
        let rightBottom = CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height)
        let rightTop = CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y)
        
        let path = UIBezierPath()
        UIColor.systemRed.set()
        path.move(to: leftTop)
        path.addLine(to: leftBottom)
        path.addLine(to: rightBottom)
        path.addLine(to: rightTop)
        path.addLine(to: leftTop)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.randomSystemColor().cgColor
        
        return shapeLayer
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
