//
//  ShapeDrawingPath.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import UIKit
import SwiftUI

struct ShapeDrawingPath: ShapeItem {
  let id: UUID
  let color: UIColor
  var points: [CGPoint]

  init(color: UIColor, points: [CGPoint] = []) {
    self.id = UUID()
    self.color = color
    self.points = points
  }

  mutating func addLine(to point: CGPoint) {
    points.append(point)
  }
}

extension ShapeDrawingPath: ShapeItemViewProviding {
  var view: some View {
    Path(points: points)
      .stroke(Color(color), lineWidth: 5)
  }
}
