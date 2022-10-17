//
//  DrawingInfo.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation
import Combine

final class DrawingInfo: Drawable {
    let color: Color
    let lineWidth: Double

    private(set) var area: Area
    private(set) var areaPublisher: CurrentValueSubject<Area, Never>

    var pointsPublisher: Published<[Point]>.Publisher { $points }
    @Published private var points: [Point] = []

    init(color: Color, lineWidth: Double, area: Area) {
        self.color = color
        self.area = area
        self.areaPublisher = .init(area)
        self.lineWidth = lineWidth
    }

    func resizeToDrawnArea(with points: [Point]) {
        var minX: Double = 0
        var maxX: Double = 0
        var minY: Double = 0
        var maxY: Double = 0
        var isFirstPoint: Bool = true
        points.forEach { point in
            if isFirstPoint {
                minX = point.x
                maxX = point.x
                minY = point.y
                maxY = point.y
                isFirstPoint = false
            } else {
                minX = min(minX, point.x)
                maxX = max(maxX, point.x)
                minY = min(minY, point.y)
                maxY = max(maxY, point.y)
            }
        }
        area = Area(
            origin: .init(
                x: minX - lineWidth,
                y: minY - lineWidth
            ),
            size: .init(
                width: maxX - minX + (lineWidth * 2),
                height: maxY - minY + (lineWidth * 2)
            )
        )
        areaPublisher.send(area)
        self.points = points.map { .init(x: $0.x - minX + lineWidth, y: $0.y - minY + lineWidth) }
    }
}
