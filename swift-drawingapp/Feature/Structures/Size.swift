//
//  Size.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

struct Size {
    var width: Double
    var height: Double
    
    func contains(_ point: Point) -> Bool {
        0...width ~= point.x &&
        0...height ~= point.y
    }
}
