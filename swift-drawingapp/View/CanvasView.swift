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
