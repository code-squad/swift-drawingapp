//
//  PolygonDrawingPresenterPort.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/30.
//

import Foundation

protocol PolygonDrawingPresenterPort: AnyObject {
    
    func update(drawing: Drawing)
}
