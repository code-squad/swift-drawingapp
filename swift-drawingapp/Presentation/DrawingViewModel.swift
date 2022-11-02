//
//  DrawingViewModel.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/29.
//

import Foundation
import Combine

class DrawingViewModel: PictureViewModel {
    let color: Color
    private(set) var points: [Point]
    let lineWidth: Double

    var pointPublisher: CurrentValueSubject<Point?, Never> = .init(nil)

    init(color: Color, points: [Point], lineWidth: Double) {
        self.color = color
        self.points = points
        self.lineWidth = lineWidth
        if points.count > 0 {
            redraw()
        }
    }

    func selected(at point: Point?) {
        defer { pointPublisher.send(point) }
        guard let point else { return }
        points.append(point)
    }

    private func redraw() {
        pointPublisher.send(nil)
        points.forEach { pointPublisher.send($0) }
        pointPublisher.send(nil)
    }
}
