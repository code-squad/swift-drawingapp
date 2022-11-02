//
//  DrawUIOutPort.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/01.
//

import Foundation

protocol DrawUIOutPort: AnyObject {
    func drawRectangle(with: RectangleViewModel)
    func readyDrawingCanvas(with: DrawingViewModel)
}
