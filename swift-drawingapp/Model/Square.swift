//
//  Square.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/22.
//

import Foundation
import CoreGraphics

class Square: Shape {
    var points: [CGPoint]
    
    init(points: [CGPoint]) {
        self.points = points
    }
}
