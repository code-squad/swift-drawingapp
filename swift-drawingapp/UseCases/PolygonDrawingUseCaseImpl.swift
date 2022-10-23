//
//  PolygonDrawingUseCaseImpl.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/18.
//

import Foundation

struct PolygonDrawingUseCaseImpl: PolygonDrawingUseCase {

    func create(point: Point?) -> Rectangle {
        return Rectangle(
            layoutInfo: .init(size: Size(width: 100, height: 100).toCGSize, center: point?.toCGPoint),
            uiInfo: .init(backgroundColor: randomSystemColorName.toSystemColor)
        )
    }
    
    func update(_ drawing: Drawing, rectangle: Rectangle) {
        drawing.items[rectangle.id] = rectangle
    }
}
