//
//  RectRepository.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/30.
//

import Combine
import Foundation

final class RectRepository {
    private let chatService: ChatServiceProtocol
    private var rectsSubject: PassthroughSubject<[Rect], Never>
    private var cancelBag: Set<AnyCancellable>

    init(chatService: ChatServiceProtocol) {
        self.chatService = chatService
        rectsSubject = .init()
        cancelBag = .init()

        chatService.dataPublisher
            .sink { data in
                guard let rect = try? JSONDecoder().decode(Rect.self, from: data) else { return }
                self.rectsSubject.send([rect])
            }
            .store(in: &cancelBag)
    }
}

extension RectRepository: CreateRectUseCase {
    func createRect(
        position: Position,
        color: DrawingColor,
        size: Size
    ) {
        let rect = Rect(
            id: .init(),
            position: position,
            color: color,
            size: size
        )

        rectsSubject.send([rect])
        chatService.chat(message: rect)
    }
}

extension RectRepository: RectsPublisherUseCase {
    var rectsPublisher: AnyPublisher<[Rect], Never> {
        rectsSubject.eraseToAnyPublisher()
    }
}
