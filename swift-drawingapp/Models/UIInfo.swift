//
//  UIInfo.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

struct UIInfo: Codable {
    
    var backgroundColor: String?
    
    var borderColor: String?
    
    var borderWidth: Double?
}

extension UIInfo {
    
    init(_ view: UIView) {
        backgroundColor = view.backgroundColor?.toString
        borderColor = view.layer.borderColor?.toString
        borderWidth = view.layer.borderWidth
    }
}
