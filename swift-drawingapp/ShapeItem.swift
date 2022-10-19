//
//  ShapeItem.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import UIKit

protocol ShapeItem: Identifiable {
  var id: UUID { get }
  var color: UIColor { get }
}

protocol ShapeItemOffsetProviding {
  var offset: CGSize { get }
}

protocol ShapeItemSelectable { }
