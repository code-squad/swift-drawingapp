//
//  RectangleInfo.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation
import Combine

typealias RectangleInPort = Paintable & StateControlProtocol
typealias RectangleOutPort = SizePublishable & StatePublishableProtocol

final class RectangleInfo: RectangleInPort, RectangleOutPort {
    let color: Color
    let lineWidth: Double

    let area: Area
    private(set) var areaPublisher: CurrentValueSubject<Area, Never>

    @Published private var isActive: Bool = false
    var isActivePublisher: Published<Bool>.Publisher { $isActive }

    init(color: Color, area: Area, lineWidth: Double) {
        self.color = color
        self.area = area
        self.lineWidth = lineWidth
        self.areaPublisher = .init(area)
    }

    func activate() {
        isActive = true
    }

    func deactivate() {
        isActive = false
    }
}
