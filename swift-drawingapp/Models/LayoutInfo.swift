//
//  LayoutInfo.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

struct LayoutInfo: Codable {
    
    var size: Size?
    
    var center: Point?
}

extension LayoutInfo {
    
    init(_ view: UIView) {
        size = view.frame.size.toSize
        center = view.center.toPoint
    }
}
