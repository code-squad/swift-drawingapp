//
//  LayoutInfo.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

struct LayoutInfo {
    
    var size: CGSize?
    
    var center: CGPoint?
}

extension LayoutInfo {
    
    init(_ view: UIView) {
        size = view.frame.size
        center = view.center
    }
}
