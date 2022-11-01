//
//  DrawingRepository.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/11/01.
//

import Combine
import Foundation

final class DrawingRepository {
    private let chatService: ChatServiceProtocol
    private var drawingDict: [UUID: Drawing]
    private var drawingsSubject: PassthroughSubject<[Drawing], Never>

    init(chatService: ChatServiceProtocol) {
        self.chatService = chatService
        drawingDict = .init()
        drawingsSubject = .init()
    }
}

extension DrawingRepository: CreateDrawingUseCase {
    func createDrawing(color: DrawingColor) -> UUID {
        let id = UUID()
        let drawing = Drawing(id: id, paths: [], color: color)
        drawingDict[id] = drawing
        return id
    }
}

extension DrawingRepository: AddDrawingPathUseCase {
    func addPath(toID id: UUID, _ path: DrawingPath) {
        drawingDict[id]?.paths.append(path)
    }
}

extension DrawingRepository: EndDrawingUseCase {
    func endDrawing(id: UUID) {
        guard let drawing = drawingDict[id] else { return }

        drawingsSubject.send([drawing])
    }
}

extension DrawingRepository: DrawingsPublisherUseCase {
    var drawingsPublisher: AnyPublisher<[Drawing], Never> {
        drawingsSubject.eraseToAnyPublisher()
    }
}
