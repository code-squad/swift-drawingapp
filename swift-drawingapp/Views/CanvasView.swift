//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by USER on 2022/10/20.
//

import UIKit

final class CanvasView: UIView {
    var shapeViews: [ShapeView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addEvent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubview(_ view: UIView) {
        guard let shapeView = view as? ShapeView else { return }
        super.addSubview(shapeView)
        shapeViews.append(shapeView)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return shapeViews.first(where: { shapeView in
            let p = convert(point, to: shapeView)
            return shapeView.bounds.contains(p)
        })
    }

    private func addEvent() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(touchedView(_:)))
        self.addGestureRecognizer(gesture)
    }

    @objc
    private func touchedView(_ sender: UITapGestureRecognizer) {
        guard let hitView = hitTest(sender.location(in: self), with: .none) as? ShapeView else { return }
        
        shapeViews.forEach({ $0.hideBorderLine() })
        hitView.showBoderLine()
    }
}

