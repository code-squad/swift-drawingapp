//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/24.
//

import Combine
import Foundation

protocol ViewModelProtocol {
    func createRect() -> Rect
    func startDrawing() -> Drawing
    func draw(id: UUID, path: DrawingPath)
}

class ViewModel: ViewModelProtocol {
    private var rectDict: [UUID: Rect] = .init()
    private var drawingDict: [UUID: Drawing] = .init()

    func createRect() -> Rect {
        let id = UUID()
        let rect = Rect(id: id, position: .random, color: .random, size: .init(width: 100, height: 100))
        rectDict[id] = rect

        return rect
    }

    func startDrawing() -> Drawing {
        let id = UUID()
        let drawing = Drawing(id: id, paths: [], color: .random)
        drawingDict[id] = drawing

        return drawing
    }

    func draw(id: UUID, path: DrawingPath) {
        drawingDict[id]?.paths.append(path)
    }
}
