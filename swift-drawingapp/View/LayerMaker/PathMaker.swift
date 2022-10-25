//
//  SquareMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/14.
//

import Foundation
import CoreGraphics
import UIKit

class PathMaker {
    
    init() {
        
    }
    
    func makePath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        
        for (i, point) in points.enumerated() {
            // 분기를 없앨 수 있는 방법은?
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        
        return path
    }
}
