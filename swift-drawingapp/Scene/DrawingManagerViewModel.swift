//
//  DrawingManagerViewModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class DrawingManagerViewModel {
    
    private let drawingManager = DrawingManager()
    private(set) var canvasViewModel: CanvasViewModel!
    
    private var addToPointStream: ((Point?) -> Void)?
    
    init() {
        canvasViewModel = .init(canvas: drawingManager.canvas)
    }
    
    func createRandomRect() {
        drawingManager.createRandomRect()
    }
    
    func startDrawing() {
        let pointStream = AsyncStream<Point> { continuation in
            addToPointStream = { point in
                if let point { continuation.yield(point) }
                else { continuation.finish() }
            }
        }
        drawingManager.createDrawing(pointStream: pointStream)
    }
    
    func addPointToDrawing(_ point: CGPoint) {
        let point = canvasViewModel.convertToPoint(point)
        addToPointStream?(point)
    }
    
    func endDrawing() {
        addToPointStream?(nil)
        addToPointStream = nil
    }
}
