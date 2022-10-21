//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import UIKit

class CanvasView: UIView {
    
    var touchBeganCompletion: ((_ point: CGPoint) -> ())?
    var touchMovedCompletion: ((_ point: CGPoint) -> ())?
    var touchEndedCompletion: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectSquare(point: CGPoint) {
        for layer in self.layer.sublayers ?? [] {
            if let shapeLayer = layer as? CAShapeLayer {
                
                if let layerPath = shapeLayer.path,
                    layerPath.contains(point) {
                    shapeLayer.lineWidth = 3
                    shapeLayer.strokeColor = UIColor.systemRed.cgColor
                    self.setNeedsLayout()
                    break
                }
            }
        }
    }
    
    func deselectSquare(point: CGPoint) {
        for layer in self.layer.sublayers ?? [] {
            if let shapeLayer = layer as? CAShapeLayer {
                if let layerPath = shapeLayer.path,
                    layerPath.contains(point) {
                    shapeLayer.lineWidth = 0
                    shapeLayer.strokeColor = UIColor.clear.cgColor
                    self.setNeedsLayout()
                    break
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        
        if let completion = touchBeganCompletion {
            completion(point)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        
        if let completion = touchMovedCompletion {
            completion(point)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let completion = touchEndedCompletion {
            completion()
        }
    }
}
