//
//  CGPoint+Extensions.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import UIKit

extension CGPoint {
    
    var toPoint: Point { .init(x: x, y: y) }
}
