//
//  SelectionOrDrawingUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/30.
//

import Foundation

protocol SelectionOrDrawingUseCase: PolygonDrawingUseCase, ItemSelectionUseCase  {
    
    func selectOrDraw(items: [Item], point: Point)
}
