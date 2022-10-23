//
//  RectangleView.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

class RectangleView: UIView {
    
    let uuidString: String
    
    init(uuidString: String, frame: CGRect) {
        self.uuidString = uuidString
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
