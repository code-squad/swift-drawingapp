//
//  InkDrawingUseCaseImpl.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/18.
//

import Foundation

class InkDrawingUseCaseImpl: InkDrawingUseCase {
    
    private(set) var currentDrawingStroke: Stroke? = nil
    
    func create(positions: [Point], ink: Ink) -> Stroke {
        return .init(positions: positions, ink: ink)
    }
    
    func update(_ drawing: Drawing, stroke: Stroke) {
        drawing.items[stroke.id] = stroke
        currentDrawingStroke = stroke
    }
    
    func update(_ drawing: Drawing, stroke: Stroke, points: [Point]) {
        let newStroke = Stroke(
            id: stroke.id,
            positions: stroke.points + points,
            ink: stroke.ink
        )
        drawing.items[stroke.id] = newStroke
        currentDrawingStroke = newStroke
    }
    
    func reset() {
        currentDrawingStroke = nil
    }
}
