//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import UIKit

class CanvasView: UIView {
    
    let lineMaker = LineMaker()
    let squareMaker = SquareMaker()
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSquareLayer() -> CAShapeLayer {
        let square = squareMaker.getSquare(rect: self.frame)
        self.layer.addSublayer(square)
        
        return square
    }
    
    func startLineDrawing(point: CGPoint) {
        let layer = lineMaker.startLineDraw(point: point)
        self.layer.addSublayer(layer)
    }
    
    func updateLinePath(point: CGPoint) {
        lineMaker.addLinePath(to: point)
    }
    
    func endLineLayer() -> CAShapeLayer {
        return lineMaker.getTempLayer()
    }
}
