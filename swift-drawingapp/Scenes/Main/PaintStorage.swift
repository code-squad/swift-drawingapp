//
//  PaintStorage.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation

final class PaintStorage {
    private var infos: [any Paintable] = []

    func addRectangle(area: Area) -> any Paintable & Selectable {
        let rectangleInfo = RectangleInfo(color: Color.randomColor, area: area)
        infos.append(rectangleInfo)
        return rectangleInfo
    }

    func addDrawing(lineWidth: Double, area: Area) -> any Drawable {
        let drawingInfo = DrawingInfo(color: Color.randomColor, lineWidth: lineWidth, area: area)
        infos.append(drawingInfo)
        return drawingInfo
    }
}
