//
//  InkDrawingUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import Foundation

protocol InkDrawingUseCase {
    
    func create(positions: [Point], ink: Ink) -> Stroke
}
