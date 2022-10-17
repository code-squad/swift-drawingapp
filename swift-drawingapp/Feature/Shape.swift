//
//  Shape.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Shape {
    var points: [Point] = [] {
        didSet {
            delegate?.pointsDidChange(points)
        }
    }
    
    weak var delegate: ShapeDelegate?
}

protocol ShapeDelegate: AnyObject {
    func pointsDidChange(_ points: [Point])
}
