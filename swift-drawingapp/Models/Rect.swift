//
//  Rect.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import UIKit

struct Rect {
    
    let point: Point
    
    let size: Size
}

extension Rect {
    
    var toCGRect: CGRect { .init(x: point.x, y: point.y, width: size.width, height: size.height) }
}
