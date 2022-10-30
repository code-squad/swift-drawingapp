//
//  ChatRepository.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/31.
//

import Foundation

final class ChatRepository {
    
    private let polygonDrawingUseCase: PolygonDrawingUseCase
    
    private let inkDrawingUseCase: InkDrawingUseCase
    
    private let syncUseCase: SyncUseCase
    
    init(
        polygonDrawingUseCase: PolygonDrawingUseCase,
        inkDrawingUseCase: InkDrawingUseCase,
        syncUseCase: SyncUseCase
    ) {
        self.polygonDrawingUseCase = polygonDrawingUseCase
        self.inkDrawingUseCase = inkDrawingUseCase
        self.syncUseCase = syncUseCase
        setup()
    }
}

private extension ChatRepository {
    
    func setup() {
        syncUseCase.setRespository(with: self)
    }
}

extension ChatRepository: ChatRepositoryPort {
    
    func receive() {
        
    }
}
