//
//  Size.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/19.
//

import UIKit

struct Size {
    
    let width: Double
    
    let height: Double
    
    static let zero = Size(width: 0, height: 0)
}

extension Size {
    
    var toCGSize: CGSize { .init(width: width, height: height)}
}
