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
            delegate?.pointsChanged(points)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case points
    }
    
    weak var delegate: ShapeDelegate?
}

extension Shape {
    convenience init(points: [Point]) {
        self.init()
        self.points = points
    }
}

protocol ShapeDelegate: AnyObject {
    func pointsChanged(_ points: [Point])
}
