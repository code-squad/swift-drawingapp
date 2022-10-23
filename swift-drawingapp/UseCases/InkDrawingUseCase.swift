//
//  InkDrawingUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import Foundation

protocol InkDrawingUseCase {
    
    var currentDrawingStroke: Stroke? { get }
    
    func create(positions: [Point], ink: Ink) -> Stroke
    
    func update(_ drawing: Drawing, stroke: Stroke)
    
    func update(_ drawing: Drawing, stroke: Stroke, points: [Point])
    
    func reset()
}
