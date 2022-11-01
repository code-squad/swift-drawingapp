//
//  Size.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/25.
//

import Foundation

struct Size: Codable {
    let width: Double
    let height: Double
}

import CoreGraphics

extension Size {

    var cgSize: CGSize {
        .init(width: width, height: height)
    }
}
