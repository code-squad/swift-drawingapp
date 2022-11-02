//
//  DrawPresenterOutPort.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/29.
//

import Foundation

protocol DrawPresenterOutPort: AnyObject {
    func drawRectangle(with rectangle: Rectangle)
    func readyDrawingCanvas(with drawing: Drawing)
}
