//
//  ShapeView.swift
//  swift-drawingapp
//
//  Created by USER on 2022/10/20.
//

import UIKit

class ShapeView: UIView {
    let uuid: UUID
    var isSelected: Bool = false {
        didSet {
            if isSelected { showBoderLine() }
            else { hideBorderLine() }
        }
    }
    
    public override init(frame: CGRect) {
        self.uuid = UUID()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showBoderLine() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 3
    }
    
    private func hideBorderLine() {
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
    }
}
