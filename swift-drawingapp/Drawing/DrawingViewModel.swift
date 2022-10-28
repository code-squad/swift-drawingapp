//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/24.
//

import Combine
import Foundation

protocol DrawingViewModelProtocol {
    func startDrawing() -> Drawing
    func draw(id: UUID, path: DrawingPath)
}

class DrawingViewModel: DrawingViewModelProtocol {
    private var drawingDict: [UUID: Drawing] = .init()
    private let chatService: ChatServiceProtocol
    private let rectsSubject: PassthroughSubject<[Rect], Never>

    init(chatService: ChatServiceProtocol) {
        self.chatService = chatService
        rectsSubject = .init()

        chatService.connect()
    }

    deinit {
        chatService.disconnect()
    }

    func createRect() {
        let rect = Rect(id: UUID(), position: .random, color: .random, size: .init(width: 100, height: 100))

        rectsSubject.send([rect])
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

extension DrawingViewModel: DrawingViewInputHandleable {
    func didTapCreateRectButton() {
        createRect()
    }
}

extension DrawingViewModel: DrawingViewOutputHandleable {
    var rects: AnyPublisher<[Rect], Never> {
        rectsSubject.eraseToAnyPublisher()
    }
}
