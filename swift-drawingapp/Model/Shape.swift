//
//  Shape.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/22.
//

import Foundation
import CoreGraphics

protocol Shape {
    var points: [CGPoint] { get set }
}
