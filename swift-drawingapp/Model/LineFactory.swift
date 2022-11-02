//
//  LineMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import Foundation
import CoreGraphics

protocol LineFactoryProtocol {
    func startLine(point: CGPoint) -> Line
    func moveLine(to point: CGPoint)
    func endLine() -> Line
}

class LineFactory: LineFactoryProtocol {
    
    private var line = Line(points: [])
    
    init() {}
        
    
    func startLine(point: CGPoint) -> Line {
        line.append(point: point)
        return line
    }
    
    func moveLine(to point: CGPoint) {
        line.append(point: point)
    }
    
    func endLine() -> Line {
        let finalLine = line
        line = Line(points: [])
        return finalLine
    }
}
