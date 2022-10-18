//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import UIKit

struct Rectangle: DrawingObject {

    static let defaultSize: CGSize = CGSize(width: 100, height: 100)
    
    var isSelected: Bool = false
    
    let identifier: String = UUID().uuidString
    let origin: CGPoint
    let size: CGSize
    let color: UIColor
}

