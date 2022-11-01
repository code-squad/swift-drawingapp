//
//  DrawingAppDriver.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation
import CoreGraphics
import Combine

class DrawingAppDriver: DrawingAppDriving {
    
    var canvasViewRepresenter: CanvasViewRepresentable {
        return canvasViewModel
    }
    
    private let model = DrawingAppModel()
    private lazy var canvasViewModel = CanvasViewModel(canvas: model.canvas)
    
    let errorMessage: PassthroughSubject<String, Never> = .init()
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        model.setChatServiceProvider(DrawingChatClient())
        
        model.$canvas.sink { canvas in
            self.canvasViewModel.setCanvas(canvas)
        }
        .store(in: &cancelBag)
    }
    
    func createRandomRect() {
        model.createRandomRect()
    }
    
    func drawPath(cgPointStream: AnyAsyncSequence<CGPoint>) {
        let pointStream = cgPointStream.map { cgPoint in
            cgPoint / self.canvasViewModel.scaleFactor
        }
        model.createDrawing(pointStream: pointStream.eraseToAnyAsyncSequence())
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
        let point = point / canvasViewModel.scaleFactor
        model.selectShape(at: point)
    }
    
    private func handleError(_ error: DrawingChatServiceError) {
        // 구현 필요
    }
}

fileprivate extension CGPoint {
    static func / (origin: CGPoint, scaleFactor: ScaleFactor2D) -> Point {
        var new = origin
        new.x /= scaleFactor.widthFactor
        new.y /= scaleFactor.heightFactor
        return Point(x: new.x, y: new.y)
    }
}
