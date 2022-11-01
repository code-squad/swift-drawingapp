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
    private var cancelBag: Set<AnyCancellable>

    init(chatService: ChatServiceProtocol) {
        self.chatService = chatService
        drawingDict = .init()
        drawingsSubject = .init()
        cancelBag = .init()

        chatService.dataPublisher
            .sink { data in
                guard let drawing = try? JSONDecoder().decode(Drawing.self, from: data) else { return }
                self.drawingsSubject.send([drawing])
            }
            .store(in: &cancelBag)
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
        chatService.chat(message: drawing)
    }
}

extension DrawingRepository: DrawingsPublisherUseCase {
    var drawingsPublisher: AnyPublisher<[Drawing], Never> {
        drawingsSubject.eraseToAnyPublisher()
    }
}
