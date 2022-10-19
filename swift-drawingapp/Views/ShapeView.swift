//
//  ShapeView.swift
//  swift-drawingapp
//
//  Created by USER on 2022/10/20.
//

import UIKit

class ShapeView: UIView {
    let uuid: UUID
    
    public init() {
        self.uuid = UUID()
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showBoderLine() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
    }
    
    func hideBorderLine() {
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
    }
}
