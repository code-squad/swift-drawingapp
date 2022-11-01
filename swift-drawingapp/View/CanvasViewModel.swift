//
//  CanvasViewModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation
import CoreGraphics

class CanvasViewModel: CanvasDelegate {
    
    @Published private(set) var shapeVMs: [ShapeViewModel] = []
    
    var transformShape: ((any ShapeProtocol, ShapeViewModel) -> ShapeViewModel)?
    
    private var canvas: Canvas
    
    private var sizeOfView: CGSize!
    private var widthScale: Double!
    private var heightScale: Double!
    
    init(canvas: Canvas) {
        self.canvas = canvas
        canvas.delegate = self
    }
    
    func setSizeOfView(_ size: CGSize) {
        sizeOfView = size
        widthScale = size.width / canvas.size.width
        heightScale = size.height / canvas.size.height
    }
    
    func convertToCGPoint(_ point: Point) -> CGPoint {
        return CGPoint(x: point.x * widthScale, y: point.y * heightScale)
    }
    
    func convertToPoint(_ cgPoint: CGPoint) -> Point {
        return Point(x: cgPoint.x / widthScale, y: cgPoint.y / heightScale)
    }
    
    func reloadCanvas() {
        self.shapeVMs = canvas.shapes
            .compactMap { $0 as? StyledShape }
            .map { self.convertToShapeViewModel($0) }
    }
    
    private func convertToShapeViewModel(_ shape: StyledShape) -> ShapeViewModel {
        let points = shape.points
            .map { convertToCGPoint($0) }
        var shapeVM = ShapeViewModel(
            shape: shape,
            points: points,
            fillColor: shape.fillColor?.cgColor,
            lineColor: shape.lineColor?.cgColor
        )
        if let transformShape {
            shapeVM = transformShape(shape, shapeVM)
        }
        return shapeVM
    }
    
    // MARK: - CanvasDelegate
    
    func shapesChanged(_ shapes: [Shape]) {
        reloadCanvas()
    }
}
