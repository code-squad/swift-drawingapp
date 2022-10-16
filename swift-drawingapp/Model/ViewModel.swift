//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/15.
//

import Foundation
import QuartzCore


protocol ViewModelDelegate: AnyObject {
    func rectSelected(layer: CAShapeLayer)
    func rectSelectedAgain(layer: CAShapeLayer)
    func startLineDrawing(point: CGPoint)
    func updateLineDrawing(point: CGPoint)
    func endLineDrawing()
    func squareButtonSelected()
    func lineButtonSelected()
}

enum DrawingType {
    case square
    case line
}

class ViewModel {
    
    private let drawingStore = DrawingStore()
    
    weak var delegate: ViewModelDelegate?
    
    var drawingType: DrawingType?
    
    init() {}
    
    func appendDrawing(layer: CAShapeLayer) {
        guard let type = self.drawingType else { return }
        let model = DrawingModel(type: type, layer: layer)
        drawingStore.appendData(data: model)
    }
    
    func processRectSelection(point: CGPoint) {
        for drawing in drawingStore.drawingList {
            let layer = drawing.layer
            
            guard let path = layer.path else { return }
            
            if drawing.type == .square {
                if path.contains(point) {
                    if layer.lineWidth == 3 {
                        delegate?.rectSelectedAgain(layer: layer)
                    } else {
                        delegate?.rectSelected(layer: layer)
                    }
                }
            }
        }
    }
    
    func handleTouchesBegan(point: CGPoint) {
        switch drawingType {
        case .square:
            processRectSelection(point: point)
        case .line:
            delegate?.startLineDrawing(point: point)
        case .none:
            return
        }
    }
    
    func handleTouchesMoved(point: CGPoint) {
        if drawingType == .line {
            delegate?.updateLineDrawing(point: point)
        }
    }
    
    func handleTouchesEnded() {
        if drawingType == .line {
            delegate?.endLineDrawing()
        }
    }
    
    func handleButtonSelected(type: DrawingType) {
        self.drawingType = type
        
        switch type {
        case .square:
            delegate?.squareButtonSelected()
        case .line:
            delegate?.lineButtonSelected()
        }
    }
}
