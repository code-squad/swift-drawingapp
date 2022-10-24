//
//  DrawingInfo.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation
import Combine

typealias DrawingInPort = Paintable & Touchable & StateControlProtocol
typealias DrawingOutPort = SizePublishable & PointPublishable & StatePublishableProtocol

final class DrawingInfo: DrawingInPort, DrawingOutPort {
    let color: Color
    let lineWidth: Double

    private(set) var area: Area
    private(set) var areaPublisher: CurrentValueSubject<Area, Never>

    private(set) var pointPublisher: CurrentValueSubject<Point?, Never>
    private(set) var points: [Point] = []

    @Published private var isActive: Bool = true
    var isActivePublisher: Published<Bool>.Publisher { $isActive }

    init(color: Color, area: Area, lineWidth: Double) {
        self.color = color
        self.area = area
        self.lineWidth = lineWidth
        self.areaPublisher = .init(area)
        self.pointPublisher = .init(nil)
    }

    func setPoints(_ points: [Point]) {
        pointPublisher.send(nil)
        self.points = points
        points.forEach { pointPublisher.send($0) }
    }

    func touch(location: Point) {
        points.append(location)
        pointPublisher.send(location)
    }

    func activate() {
        points = []
        pointPublisher.send(nil)
        isActive = true
    }

    func deactivate() {
        isActive = false
        resizeToDrawnArea()
    }

    private func resizeToDrawnArea() {
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
        setPoints(points.map { .init(x: $0.x - minX + lineWidth, y: $0.y - minY + lineWidth) })
    }
}
