//
//  Selectable.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

protocol Selectable: AnyObject {
    var isSelected: Bool { get set }
    func contains(_ point: Point) -> Bool
}
