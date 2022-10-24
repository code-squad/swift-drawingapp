//
//  PaintManager.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation
import Combine

final class PaintManager {
    private(set) var rectanglePublisher: CurrentValueSubject<(any RectangleInPort & RectangleOutPort)?, Never>
    private(set) var drawingPublisher: CurrentValueSubject<(any DrawingInfo & DrawingOutPort)?, Never>

    private var paints: [any Paintable] = []

    init() {
        rectanglePublisher = .init(nil)
        drawingPublisher = .init(nil)
    }

    func addPaint(_ paint: any Paintable) {
        if let p = paint as? any DrawingInfo & DrawingOutPort {
            drawingPublisher.send(p)
            paints.append(paint)
        } else if let p = paint as? any RectangleInPort & RectangleOutPort {
            rectanglePublisher.send(p)
            paints.append(paint)
        } else {
            return
        }
    }
}

protocol Painter {
    associatedtype Drawble
    func draw(color: Color, area: Area, lineWidth: Double) -> Drawble
}

class RectanglePainter: Painter {
    func draw(color: Color, area: Area, lineWidth: Double) -> any RectangleInPort & RectangleOutPort {
        RectangleInfo(color: Color.randomColor, area: area, lineWidth: lineWidth)
    }
}

class DrawingPainter: Painter {
    func draw(color: Color, area: Area, lineWidth: Double) -> any DrawingInfo & DrawingOutPort {
        DrawingInfo(color: color, area: area, lineWidth: lineWidth)
    }
}
