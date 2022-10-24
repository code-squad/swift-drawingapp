//
//  PaintProtocols.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation
import Combine

enum Color: CaseIterable {
    static var randomColor: Self {
        Color.allCases.randomElement() ?? .blue
    }

    case blue
    case brown
    case cyan
    case green
    case indigo
    case mint
    case orange
    case pink
    case purple
    case teal
    case yellow
}

struct Point: Equatable {
    let x: Double
    let y: Double
}

struct Area {
    struct Size {
        let width: Double
        let height: Double
    }
    let origin: Point
    let size: Size
}

protocol Paintable: Identifiable {
    var color: Color { get }
    var area: Area { get }
    var lineWidth: Double { get }
}

protocol SizePublishable {
    var areaPublisher: CurrentValueSubject<Area, Never> { get }
}

protocol Touchable {
    func touch(location: Point)
}

protocol PointPublishable {
    var pointPublisher: CurrentValueSubject<Point?, Never> { get }
}

protocol StateControlProtocol {
    func activate()
    func deactivate()
}

protocol StatePublishableProtocol {
    var isActivePublisher: Published<Bool>.Publisher { get }
}
