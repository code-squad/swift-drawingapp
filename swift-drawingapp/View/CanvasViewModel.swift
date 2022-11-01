//
//  CanvasViewModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation
import Combine
import CoreGraphics

struct CanvasViewModel: CanvasViewRepresentable {
    var shapes: any Publisher<[(UUID, ShapeViewRepresentable)], Never> {
        shapesPublisher
    }
    
    var transformShape: (UUID, ShapeViewRepresentable) -> ShapeViewRepresentable = { $1 }
    
    private var canvas: Canvas
    
    private let shapesPublisher: PassthroughSubject<[(UUID, ShapeViewRepresentable)], Never> = .init()
    
    private var scaleFactor: ScaleFactor2D!
    
    init(canvas: Canvas) {
        self.canvas = canvas
    }
    
    mutating func setSizeOfView(_ size: CGSize) {
        scaleFactor = ScaleFactor2D(
            widthFactor: size.width / canvas.size.width,
            heightFactor: size.height / canvas.size.height)
    }
    
    func setCanvas(_ canvas: Canvas) {
        let shapes = canvas.shapes.map { id, shape in
            (id, convertToShapeViewModel(shape))
        }
        shapesPublisher.send(shapes)
    }
    
    private func convertToShapeViewModel(_ shape: any ShapeProtocol) -> ShapeViewModel {
        
        var shapeViewModel = ShapeViewModel()
        shapeViewModel.setShape(shape, scaleFactor: scaleFactor)
        return shapeViewModel
    }
}
