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

protocol CreateDrawingUseCase {
    func createDrawing(color: DrawingColor) -> UUID
}

protocol AddDrawingPathUseCase {
    func addPath(toID id: UUID, _ path: DrawingPath)
}

protocol EndDrawingUseCase {
    func endDrawing(id: UUID)
}

protocol DrawingsPublisherUseCase {
    var drawingsPublisher: AnyPublisher<[Drawing], Never> { get }
}

class DrawingViewModel {
    private let createRectUseCase: CreateRectUseCase
    private let rectsPublisherUseCase: RectsPublisherUseCase
    private let createDrawingUseCase: CreateDrawingUseCase
    private let addDrawingPathUseCase: AddDrawingPathUseCase
    private let endDrawingUseCase: EndDrawingUseCase
    private let drawingPublisherUseCase: DrawingsPublisherUseCase

    private let rectsSubject: PassthroughSubject<[Rect], Never>
    private let drawingsSubject: PassthroughSubject<[Drawing], Never>
    private let currentDrawingColorSubject: PassthroughSubject<DrawingColor, Never>
    private var currentDrawingID: UUID?
    private var cancelBag: Set<AnyCancellable>

    init(
        chatService: ChatServiceProtocol,
        createRectUseCase: CreateRectUseCase,
        rectsPublisherUseCase: RectsPublisherUseCase,
        createDrawingUseCase: CreateDrawingUseCase,
        addDrawingPathUseCase: AddDrawingPathUseCase,
        endDrawingUseCase: EndDrawingUseCase,
        drawingPublisherUseCase: DrawingsPublisherUseCase
    ) {
        self.createRectUseCase = createRectUseCase
        self.rectsPublisherUseCase = rectsPublisherUseCase
        self.createDrawingUseCase = createDrawingUseCase
        self.addDrawingPathUseCase = addDrawingPathUseCase
        self.endDrawingUseCase = endDrawingUseCase
        self.drawingPublisherUseCase = drawingPublisherUseCase

        rectsSubject = .init()
        drawingsSubject = .init()
        currentDrawingColorSubject = .init()
        cancelBag = .init()

        subscribe()
    }

    private func subscribe() {
        rectsPublisherUseCase.rectsPublisher
            .sink { rects in
                self.addRects(rects)
            }
            .store(in: &cancelBag)

        drawingPublisherUseCase.drawingsPublisher
            .sink { drawings in
                self.addDrawings(drawings)
            }
            .store(in: &cancelBag)
    }

    private func addRects(_ rects: [Rect]) {
        rectsSubject.send(rects)
    }

    private func startDrawing() {
        let currentDrawingColor: DrawingColor = .random
        currentDrawingID = createDrawingUseCase.createDrawing(color: currentDrawingColor)
        currentDrawingColorSubject.send(currentDrawingColor)
    }

    private func addDrawings(_ drawings: [Drawing]) {
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
        guard let id = currentDrawingID else { return }

        addDrawingPathUseCase.addPath(toID: id, path)
    }

    func endDrawing() {
        guard let id = currentDrawingID else { return }

        endDrawingUseCase.endDrawing(id: id)
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
