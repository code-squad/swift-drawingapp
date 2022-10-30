//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/24.
//

import Combine
import Foundation

protocol CreateRectUseCase {
    func createRect(position: Position, color: DrawingColor, size: Size)
}

protocol RectsPublisherUseCase {
    var rectsPublisher: AnyPublisher<[Rect], Never> { get }
}

class DrawingViewModel {
    private let createRectUseCase: CreateRectUseCase
    private let rectsPublisherUseCase: RectsPublisherUseCase
    private let chatService: ChatServiceProtocol
    private let rectsSubject: PassthroughSubject<[Rect], Never>
    private let drawingsSubject: PassthroughSubject<[Drawing], Never>
    private let currentDrawingColorSubject: PassthroughSubject<DrawingColor, Never>
    private var currentDrawing: Drawing?
    private var cancelBag: Set<AnyCancellable>

    init(
        chatService: ChatServiceProtocol,
        createRectUseCase: CreateRectUseCase,
        rectsPublisherUseCase: RectsPublisherUseCase
    ) {
        self.chatService = chatService
        self.createRectUseCase = createRectUseCase
        self.rectsPublisherUseCase = rectsPublisherUseCase
        rectsSubject = .init()
        drawingsSubject = .init()
        currentDrawingColorSubject = .init()
        cancelBag = .init()

        chatService.connect()

        rectsPublisherUseCase.rectsPublisher
            .sink { rects in
                self.addRects(rects)
            }
            .store(in: &cancelBag)
    }

    deinit {
        chatService.disconnect()
    }

    private func addRects(_ rects: [Rect]) {
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
        createRectUseCase.createRect(
            position: .random,
            color: .random,
            size: .init(width: 100, height: 100)
        )
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
