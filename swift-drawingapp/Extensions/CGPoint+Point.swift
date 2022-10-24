//
//  CGPoint+Point.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/22.
//

import Foundation

extension CGPoint {
    func convertToPoint() -> Point {
        Point(x: Double(self.x), y: Double(self.y))
    }
}
