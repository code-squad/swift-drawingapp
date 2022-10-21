//
//  LineMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import Foundation
import CoreGraphics

class LineFactory {
    
    private var points: [CGPoint] = []
    
    init() {}
        
    
    func startLine(point: CGPoint) {
        points.append(point)
    }
    
    func moveLine(to point: CGPoint) {
        points.append(point)
    }
    
    func endLine() -> [CGPoint] {
        let finalPoints = points
        points.removeAll()
        return finalPoints
    }
}
