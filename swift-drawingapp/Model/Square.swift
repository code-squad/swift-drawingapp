//
//  Square.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/22.
//

import Foundation
import CoreGraphics

class Square: Shape, Identifiable {
    let uuid: UUID = UUID()
    var points: [CGPoint]
    
    init(points: [CGPoint]) {
        self.points = points
    }
    
    func isContain(point: CGPoint) -> Bool {
        let xList = points.map { $0.x }
        let yList = points.map { $0.y }
        
        guard let minX = xList.min(),
              let maxX = xList.max(),
              let minY = yList.min(),
              let maxY = yList.max() else {
            return false
        }
        let rangeX = minX...maxX
        let rangeY = minY...maxY
        return rangeX.contains(point.x) && rangeY.contains(point.y)
    }
}
