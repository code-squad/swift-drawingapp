//
//  ShapeRectangle.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import UIKit
import SwiftUI

struct ShapeRectangle: ShapeItem, ShapeItemOffsetProviding, ShapeItemSelectable {
  let id: UUID
  let color: UIColor
  let size: CGSize
  let offset: CGSize

  init(color: UIColor, size: CGSize, offset: CGSize) {
    self.id = UUID()
    self.color = color
    self.size = size
    self.offset = offset
  }
}

extension ShapeRectangle: ShapeItemViewProviding {
  var view: some View {
    Rectangle()
      .frame(width: size.width, height: size.height)
      .foregroundColor(Color(color))
  }
}
