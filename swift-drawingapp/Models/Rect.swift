//
//  Rect.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import Foundation

struct Rect: Identifiable {
    let id: UUID
    let position: Position
    let color: DrawingColor
    let size: Size
}
