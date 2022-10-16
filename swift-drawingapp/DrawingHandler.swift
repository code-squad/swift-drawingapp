//
//  DrawingHandler.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import Foundation

protocol DrawingHandleable {
    func startDrawing()
    func draw(path: DrawingPath)
    func endDrawing()
}

final class DrawingHandler: DrawingHandleable {
    private var currentDrawingPaths: [DrawingPath] = []
    private var drawingDict: [UUID: Drawing] = .init()

    func startDrawing() {
        currentDrawingPaths = []
    }

    func draw(path: DrawingPath) {
        currentDrawingPaths.append(path)
    }

    func endDrawing() {
        let id = UUID()
        drawingDict[id] = Drawing(id: id, paths: currentDrawingPaths)
        currentDrawingPaths = []
    }
}
