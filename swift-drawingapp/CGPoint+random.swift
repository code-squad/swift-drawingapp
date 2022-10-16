//
//  CGPoint+random.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import Foundation

extension CGPoint {
    static func random(in rect: CGRect) -> Self {
        return random(
            min: .init(x: rect.minX, y: rect.minY),
            max: .init(x: rect.maxX, y: rect.maxY)
        )
    }

    static func random(min: Self, max: Self) -> Self {
        return .init(x: .random(in: min.x...max.x), y: .random(in: min.y...max.y))
    }
}
