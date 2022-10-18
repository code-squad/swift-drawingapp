//
//  PolygonDrawingUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import Foundation

protocol PolygonDrawingUseCase {
    
    func create(point: Point) -> RectangleView
}
