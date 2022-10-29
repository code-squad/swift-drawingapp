//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/24.
//

import Combine
import Foundation

class DrawingViewModel {
    private let chatService: ChatServiceProtocol
    private let rectsSubject: PassthroughSubject<[Rect], Never>
    private let drawingsSubject: PassthroughSubject<[Drawing], Never>
    private let currentDrawingColorSubject: PassthroughSubject<DrawingColor, Never>
    private var currentDrawing: Drawing?

    init(chatService: ChatServiceProtocol) {
        self.chatService = chatService
        rectsSubject = .init()
        drawingsSubject = .init()
        currentDrawingColorSubject = .init()

        chatService.connect()
    }

    deinit {
        chatService.disconnect()
    }

    private func createRect() {
        let rect = Rect(id: UUID(), position: .random, color: .random, size: .init(width: 100, height: 100))

        sendRects([rect])
    }

    private func sendRects(_ rects: [Rect]) {
        rectsSubject.send(rects)
    }

    private func startDrawing() {
        let currentDrawingColor: DrawingColor = .random
        let drawing = Drawing(id: UUID(), paths: [], color: currentDrawingColor)

        currentDrawing = drawing
        currentDrawingColorSubject.send(currentDrawingColor)
    }

    private func sendDrawings(_ drawings: [Drawing]) {
        drawingsSubject.send(drawings)
    }
}

extension DrawingViewModel: DrawingViewInputHandleable {
    func didTapCreateRectButton() {
        createRect()
    }

    func didTapDrawingButton() {
        startDrawing()
    }

    func draw(to path: DrawingPath) {
        currentDrawing?.paths.append(path)
    }

    func endDrawing() {
        guard let currentDrawing = currentDrawing else { return }

        sendDrawings([currentDrawing])
    }
}

extension DrawingViewModel: DrawingViewOutputHandleable {
    var rectsPublisher: AnyPublisher<[Rect], Never> {
        rectsSubject.eraseToAnyPublisher()
    }

    var currentDrawingColorPublisher: AnyPublisher<DrawingColor, Never> {
        currentDrawingColorSubject.eraseToAnyPublisher()
    }

    var drawingsPublisher: AnyPublisher<[Drawing], Never> {
        drawingsSubject.eraseToAnyPublisher()
    }
}
