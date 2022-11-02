//
//  RectangleViewModel.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/29.
//

import Foundation
import Combine

class RectangleViewModel: PictureViewModel {
    let color: Color
    let points: [Point]
    let lineWidth: Double

    var pointPublisher: PassthroughSubject<Point?, Never> = .init()

    init(color: Color, points: [Point], lineWidth: Double) {
        self.color = color
        self.points = points
        self.lineWidth = lineWidth
    }

    func selected(at point: Point?) {
        pointPublisher.send(point)
    }
}
