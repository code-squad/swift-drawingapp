//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

final class Rectangle: Picture {
    let color: Color
    let points: [Point]
    let lineWidth: Double

    init(color: Color, points: [Point], lineWidth: Double) {
        self.color = color
        self.points = points
        self.lineWidth = lineWidth
    }

    func selected(on location: Point?) {}
}
