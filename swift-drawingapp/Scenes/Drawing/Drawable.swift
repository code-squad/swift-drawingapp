//
//  Drawable.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation
import Combine

struct Point: Equatable {
    let x: Double
    let y: Double
}

protocol Drawable: Paintable {
    var lineWidth: Double { get }
    var pointsPublisher: Published<[Point]>.Publisher { get }
    var areaPublisher: CurrentValueSubject<Area, Never> { get }
    func resizeToDrawnArea(with points: [Point])
}
