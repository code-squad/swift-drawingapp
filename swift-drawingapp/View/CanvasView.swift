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
        let rect = squareMaker.getRect(rect: self.frame)
        
        let leftTop = CGPoint(x: rect.origin.x, y: rect.origin.y)
        let leftBottom = CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height)
        let rightBottom = CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height)
        let rightTop = CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y)
        
        let path = UIBezierPath()
        UIColor.systemRed.set()
        path.move(to: leftTop)
        path.addLine(to: leftBottom)
        path.addLine(to: rightBottom)
        path.addLine(to: rightTop)
        path.addLine(to: leftTop)
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.randomSystemColor().cgColor
        
        self.layer.addSublayer(shapeLayer)
        
        return shapeLayer
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
