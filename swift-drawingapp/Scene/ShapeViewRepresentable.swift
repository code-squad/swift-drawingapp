//
//  ShapeViewRepresentable.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import UIKit

protocol ShapeViewRepresentable {
    var points: [CGPoint] { get }
    var color: CGColor? { get }
    var lineColor: CGColor? { get }
}
