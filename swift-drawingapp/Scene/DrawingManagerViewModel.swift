//
//  DrawingManagerViewModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation
import Combine

class DrawingManagerViewModel: DrawingManagerDelegate {
    
    private let drawingManager = DrawingManager()
    private(set) var canvasViewModel: CanvasViewModel!
    
    private var addToPointStream: ((Point?) -> Void)?
    
    let errorMessage: PassthroughSubject<String, Never> = .init()
    
    init() {
        canvasViewModel = .init(canvas: drawingManager.canvas)
        canvasViewModel.transformShape = { (shape, shapeVM) in
            var shapeVM = shapeVM
            if (self.drawingManager.selectedShapes.contains { $0 === shape }) {
                shapeVM.lineColor = Color.systemRed.cgColor
            }
            return shapeVM
        }
        drawingManager.delegate = self
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
    
    func startSync() {
        Task {
            do {
                try await drawingManager.startSynchronize()
            } catch let error as DrawingManager.Error {
                handleError(error)
            } catch {}
        }
    }
    
    func selectShape(at point: CGPoint) {
        let point = canvasViewModel.convertToPoint(point)
        drawingManager.selectShape(at: point)
    }
    
    // MARK: - DrawingManagerDelegate
    
    func selectedShapesChanged(_ selectedShapes: [Shape]) {
        canvasViewModel.reloadCanvas()
    }
    
    func receivedShapesChanged(_ receivedShapes: [Shape]) {
        canvasViewModel.reloadCanvas()
    }
    
    private func handleError(_ error: DrawingManager.Error) {
        switch error {
        case .login:
            errorMessage.send("로그인 오류")
        case .send:
            errorMessage.send("데이터 전송 오류")
        case .receive:
            errorMessage.send("데이터 수신 오류")
        }
    }
}
