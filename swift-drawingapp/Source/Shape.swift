//
//  Shape.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

protocol Shape: AnyObject {
    var points: [Point] { get }
    func setCanvas(_ canvas: Canvas)
}
