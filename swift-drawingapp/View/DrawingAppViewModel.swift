//
//  DrawingAppViewModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation
import Combine

class DrawingAppViewModel {
    
    private let model = DrawingAppModel()
    private(set) var canvasViewModel: CanvasViewModel!
    
    private var addToPointStream: ((Point?) -> Void)?
    
    let errorMessage: PassthroughSubject<String, Never> = .init()
    
    init() {
        canvasViewModel = .init(canvas: model.canvas)
        canvasViewModel.transformShape = { (shape, shapeVM) in
            var shapeVM = shapeVM
            if (self.model.selectedShapeIDs.contains { $0 == shape.id }) {
                shapeVM.lineColor = Color.systemRed.cgColor
            }
            return shapeVM
        }
        model.setChatServiceProvider(DrawingChatClient())
    }
    
    func createRandomRect() {
        model.createRandomRect()
    }
    
    func startDrawing() {
        let pointStream = AsyncStream<Point> { continuation in
            addToPointStream = { point in
                if let point { continuation.yield(point) }
                else { continuation.finish() }
            }
        }
        model.createDrawing(pointStream: pointStream.eraseToAnyAsyncSequence())
    }
    
    func addPointToDrawing(_ point: CGPoint) {
        let point = canvasViewModel.convertToPoint(point)
        addToPointStream?(point)
    }
    
    func endDrawing() {
        addToPointStream?(nil)
        addToPointStream = nil
    }
    
    func startSync() {
        Task {
            do {
                try await model.startSynchronize()
            } catch let error as DrawingChatServiceError {
                handleError(error)
            } catch {}
        }
    }
    
    func selectShape(at point: CGPoint) {
        let point = canvasViewModel.convertToPoint(point)
        model.selectShape(at: point)
    }
    
    private func handleError(_ error: DrawingChatServiceError) {
        // 구현 필요
    }
}
