//
//  Drawing.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import Foundation

struct Drawing: Identifiable, Codable {
    let id: UUID
    var paths: [DrawingPath]
    let color: DrawingColor
}
