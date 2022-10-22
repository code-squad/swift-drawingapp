//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/15.
//

import Foundation
import QuartzCore

// 무슨 기준으로 나눈거니?
// 기대되는 출력값.
// viewModel에서 로직 처리 후 출력값을 전달하기 때문에, 기대되는 출력값들을 delegate로 정의하고 ViewController와 연결
protocol ViewModelDelegate: AnyObject {
    func selectSquare(point: CGPoint)
    func selectSquareAgain(point: CGPoint)
    func drawSquare(points: [CGPoint])
    func startLineDraw(point: CGPoint)
    func updateLineDraw(point: CGPoint)
    func endLineDraw(points: [CGPoint])
}

enum DrawingMode {
    case square
    case line
}

class ViewModel {
    
    private let drawingStore = DrawingStore()
    private let drawingFactory = DrawingFactory()
    
    weak var delegate: ViewModelDelegate?
    
    var drawingMode: DrawingMode?
    
    init() {}
    
    func appendDrawing(shape: Shape) {
        let model = DrawingModel(shape: shape)
        drawingStore.appendData(data: model)
    }
    
    // selection을 처리하는 로직을 분리하면 좋을듯
    func processRectSelection(point: CGPoint) {
        for drawing in drawingStore.drawingList {
            let points = drawing.shape.points
            
            if drawing.shape is Square {
                if isSquareContain(points: points, targetPoint: point) {
                    if drawing.isSelected {
                        delegate?.selectSquareAgain(point: point)
                    } else {
                        delegate?.selectSquare(point: point)
                    }
                    break
                }
            }
        }
        
        let newDrawingList = drawingStore.drawingList.map { drawingModel -> DrawingModel in
            if drawingModel.shape is Square {
                if isSquareContain(points: drawingModel.shape.points, targetPoint: point) {
                    return DrawingModel(isSelected: !drawingModel.isSelected, shape: drawingModel.shape)
                }
            }
            return drawingModel
        }
        
        drawingStore.updateData(data: newDrawingList)
    }
    
    func isSquareContain(points: [CGPoint], targetPoint: CGPoint) -> Bool {
        let xList = points.map { $0.x }
        let yList = points.map { $0.y }
        
        guard let minX = xList.min(),
              let maxX = xList.max(),
              let minY = yList.min(),
              let maxY = yList.max() else {
            return false
        }
        let rangeX = minX...maxX
        let rangeY = minY...maxY
        return rangeX.contains(targetPoint.x) && rangeY.contains(targetPoint.y)
    }
    
    func handleTouchesBegan(point: CGPoint) {
        switch drawingMode {
        case .square:
            processRectSelection(point: point)
        case .line:
            drawingFactory.startLinePoint(point: point)
            delegate?.startLineDraw(point: point)
        case .none:
            return
        }
    }
    
    func handleTouchesMoved(point: CGPoint) {
        if drawingMode == .line {
            drawingFactory.updateLinePoints(point: point)
            
            delegate?.updateLineDraw(point: point)
        }
    }
    
    func handleTouchesEnded() {
        if drawingMode == .line {
            let line = drawingFactory.endLinePoints()
            appendDrawing(shape: line)
            
            delegate?.endLineDraw(points: line.points)
        }
    }
    
    func handleSquareButtonSelected(rect: CGRect) {
        self.drawingMode = .square
        
        let square = drawingFactory.makeSquare(rect: rect)
        appendDrawing(shape: square)
        
        delegate?.drawSquare(points: square.points)
    }
    
    func handleLineButtonSelected() {
        self.drawingMode = .line
    }
}
