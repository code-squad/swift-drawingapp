//
//  InkDrawingUseCaseImpl.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/18.
//

import Foundation

struct InkDrawingUseCaseImpl: InkDrawingUseCase {
    
    func create(positions: [Point], ink: Ink) -> Stroke {
        return .init(positions: positions, ink: ink)
    }
}
