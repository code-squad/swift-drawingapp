//
//  LineMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import Foundation
import CoreGraphics

class LineFactory {
    
    private var line = Line()
    
    init() {}
        
    
    func startLine(point: CGPoint) -> Line {
        line.points.append(point)
        return line
    }
    
    func moveLine(to point: CGPoint) {
        line.points.append(point)
    }
    
    func endLine() -> Line {
        let finalLine = line
        line = Line()
        return finalLine
    }
}
