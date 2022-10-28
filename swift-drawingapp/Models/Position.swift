//
//  Position.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/25.
//

import Foundation

struct Position {
    let x: Double
    let y: Double
}

extension Position {

    /// 0...1 사이의 값
    static var random: Self {
        .init(x: .random(in: 0...1), y: .random(in: 0...1))
    }
}

import CoreGraphics

extension Position {

    var cgPoint: CGPoint {
        .init(x: x, y: y)
    }
}
