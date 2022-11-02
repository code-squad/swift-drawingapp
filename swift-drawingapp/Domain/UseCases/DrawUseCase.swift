//
//  DrawUseCase.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol DrawUseCase {
    func drawRectangle(inside area: Area)
    func readyDrawingCanvas()
}
