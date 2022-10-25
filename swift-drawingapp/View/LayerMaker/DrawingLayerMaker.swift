//
//  DrawingMaker.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import UIKit

protocol DrawingLayerMakerProtocol {
    func makeSquareLayer(square: Square, color: ColorAssets) -> CAShapeLayer
    func makeLineLayer(line: Line, color: ColorAssets) -> CAShapeLayer
    func startLineDrawing(line: Line, color: ColorAssets) -> CAShapeLayer?
    func updateLinePath(point: CGPoint)
    func endLineDrawing()
}

class DrawingLayerMaker: DrawingLayerMakerProtocol {
    
    let drawingMaker = DrawingMaker()
    let pathMaker = PathMaker()
    
    init() {}
    
    func makeSquareLayer(square: Square, color: ColorAssets) -> CAShapeLayer {
        let path = pathMaker.makePath(points: square.points)
        
        let squareLayer = CAShapeLayer()
        squareLayer.path = path.cgPath
        squareLayer.fillColor = UIColor.getColor(colorAssets: color).cgColor
        squareLayer.name = "\(square.uuid)"
        return squareLayer
    }
    
    func startLineDrawing(line: Line, color: ColorAssets) -> CAShapeLayer? {
        guard let point = line.points.first else {
            return nil
        }
        let lineLayer = drawingMaker.startLineDraw(point: point)
        lineLayer.strokeColor = UIColor.getColor(colorAssets: color).cgColor
        lineLayer.name = "\(line.uuid)"
        return lineLayer
    }
        
    func updateLinePath(point: CGPoint) {
        drawingMaker.addLinePath(to: point)
    }
    
    func endLineDrawing() {
        drawingMaker.endLineDraw()
    }
    
    func makeLineLayer(line: Line, color: ColorAssets) -> CAShapeLayer {
        let path = pathMaker.makePath(points: line.points)
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = path.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.lineWidth = 4
        lineLayer.strokeColor = UIColor.getColor(colorAssets: color).cgColor
        lineLayer.name = "\(line.uuid)"
        return lineLayer
    }
}
