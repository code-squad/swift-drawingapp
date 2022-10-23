//
//  UIInfo.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

struct UIInfo {
    
    var backgroundColor: UIColor?
    
    var borderColor: CGColor?
    
    var borderWidth: CGFloat?
}

extension UIInfo {
    
    init(_ view: UIView) {
        backgroundColor = view.backgroundColor
        borderColor = view.layer.borderColor
        borderWidth = view.layer.borderWidth
    }
}
