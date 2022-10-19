//
//  SquareView.swift
//  swift-drawingapp
//
//  Created by USER on 2022/10/20.
//

import UIKit

final class SquareView: ShapeView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
