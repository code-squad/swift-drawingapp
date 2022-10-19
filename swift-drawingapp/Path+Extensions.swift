//
//  Path+Extensions.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import SwiftUI

extension Path {
  init(points: [CGPoint]) {
    self.init()
    if let firstPoint = points.first {
      move(to: firstPoint)
    }
    addLines(Array(points.dropFirst()))
  }
}
