//
//  DrawingApp.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class DrawingApp {
    private(set) var canvas: Canvas = Canvas(size: .init(width: 500, height: 500))
    private(set) var selectedShapes: [Shape] = []
    
    func createRandomRect() {
        let rectSize = Size(width: 100, height: 100)
        let originPoint = Point(
            x: Double.random(in: 0...canvas.size.width-rectSize.width),
            y: Double.random(in: 0...canvas.size.height-rectSize.height)
        )
        let rect = StyledRectangle(origin: originPoint, size: rectSize)
        canvas.addShape(rect)
    }
    
    func createDrawing(pointStream: AsyncStream<Point>) {
        Task { @MainActor in
            let drawing = StyledDrawing()
            canvas.addShape(drawing)
            for await point in pointStream {
                drawing.addPoint(point)
            }
        }
    }
    
    /// 해당 지점에 있는 도형의 선택 상태를 토글한다.
    func selectShape(at point: Point) {
        guard let shape = canvas.findShape(at: point) else { return }
        if let index = (selectedShapes.firstIndex { $0 === shape }) {
            selectedShapes.remove(at: index)
        } else {
            selectedShapes.append(shape)
        }
    }
}
