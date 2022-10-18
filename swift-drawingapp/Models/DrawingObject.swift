//
//  DrawingObject.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import Foundation
import UIKit

protocol DrawingObject {

    var identifier: String { get }
    var origin: CGPoint { get }
    var color: UIColor { get }
    var isSelected: Bool { get set }
}
