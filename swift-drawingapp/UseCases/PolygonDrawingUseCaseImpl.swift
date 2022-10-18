//
//  PolygonDrawingUseCaseImpl.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/18.
//

import Foundation

struct PolygonDrawingUseCaseImpl: PolygonDrawingUseCase {

    func create(point: Point) -> RectangleView {
        return .init(
            layoutInfo: .init(size: Size(width: 300, height: 150), center: point),
            uiInfo: .init(backgroundColor: randomSystemColorName)
        )
    }
}
