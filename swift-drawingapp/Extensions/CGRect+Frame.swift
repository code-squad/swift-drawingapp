//
//  CGRect+Frame.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation

extension CGRect {
    static func frame(_ area: Area) -> CGRect {
        CGRect(
            x: CGFloat(area.origin.x),
            y: CGFloat(area.origin.y),
            width: CGFloat(area.size.width),
            height: CGFloat(area.size.height)
        )
    }
}
