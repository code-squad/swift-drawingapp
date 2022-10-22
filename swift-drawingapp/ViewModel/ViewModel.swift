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
    func selectSquare(square: Square)
    func drawSquare(square: Square)
    func startLineDraw(line: Line)
    func updateLineDraw(point: CGPoint)
    func endLineDraw()
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
        drawingStore.appendData(data: shape)
    }
    
    func processRectSelection(point: CGPoint) {
        if let square = findSquare(point: point) {
            delegate?.selectSquare(square: square)
        }
    }
    
    func findSquare(point: CGPoint) -> Square? {
        let drawing = drawingStore.drawingList
            .compactMap { $0 as? Square }
            .first { $0.isContain(point: point) }
        
        return drawing
    }
    
    func handleTouchesBegan(point: CGPoint) {
        switch drawingMode {
        case .square:
            processRectSelection(point: point)
        case .line:
            let line = drawingFactory.startLinePoint(point: point)
            delegate?.startLineDraw(line: line)
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
            
            delegate?.endLineDraw()
        }
    }
    
    func handleSquareButtonSelected(rect: CGRect) {
        self.drawingMode = .square
        
        let square = drawingFactory.makeSquare(rect: rect)
        appendDrawing(shape: square)
        
        delegate?.drawSquare(square: square)
    }
    
    func handleLineButtonSelected() {
        self.drawingMode = .line
    }
}
