//
//  PathShape.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import UIKit

struct PathShape: DrawingObject {

    var isSelected: Bool = false

    let identifier: String = UUID().uuidString
    var origin: CGPoint
    var size: CGSize
    let color: UIColor
    var paths: [CGPoint]
}
