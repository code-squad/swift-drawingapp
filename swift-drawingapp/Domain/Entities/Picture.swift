//
//  Picture.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

class Picture: Identifiable, Codable {
    let color: Color
    private(set) var points: [Point]
    let lineWidth: Double

    init(color: Color, points: [Point], lineWidth: Double) {
        self.color = color
        self.points = points
        self.lineWidth = lineWidth
    }

    func addPoint(_ point: Point) {
        points.append(point)
    }

    func selected(on location: Point?) {}
}
