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
}

enum DrawingType {
    case square
    case line
}

class ViewModel {
    
    private let drawingStore = DrawingStore()
    private let squareMaker = SquareMaker()
    private let lineMaker = LineMaker()
    
    weak var delegate: ViewModelDelegate?
    
    var drawingType: DrawingType?
    
    init() {}
    
    func getRect(rect: CGRect) -> CGRect {
        squareMaker.getRect(rect: rect)
    }
    
    func appendDrawing(layer: CAShapeLayer) {
        guard let type = self.drawingType else { return }
        let model = DrawingModel(type: type, layer: layer)
        drawingStore.appendData(data: model)
    }
    
    func startLineDrawing(point: CGPoint) -> CAShapeLayer {
        let layer = lineMaker.startLineDraw(point: point)
        return layer
    }
    
    func updateLinePath(point: CGPoint) {
        lineMaker.addLinePath(to: point)
    }
    
    func endLineDrawing() {
        let layer = lineMaker.getTempLayer()
        let model = DrawingModel(type: .line, layer: layer)
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
}
