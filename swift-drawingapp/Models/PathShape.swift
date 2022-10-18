//
//  PathShape.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import UIKit

struct PathShape: DrawingObject {

    var isSelected: Bool

    let identifier: String = UUID().uuidString
    let origin: CGPoint
    let color: UIColor
}
