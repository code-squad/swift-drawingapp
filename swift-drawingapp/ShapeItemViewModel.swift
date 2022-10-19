//
//  ShapeItemViewModel.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import Foundation

struct ShapeItemViewModel {
  let item: any ShapeItem & ShapeItemViewProviding
  var isSelected: Bool
  var didTap: (() -> Void)?

  var offset: CGSize {
    return (item as? ShapeItemOffsetProviding)?.offset ?? .zero
  }
}
