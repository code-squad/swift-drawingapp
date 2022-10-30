//
//  PolygonDrawingUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import Foundation

protocol PolygonDrawingUseCase {
    
    var drawing: Drawing { get }
    
    @discardableResult
    func draw(tool: Tool, layoutInfo: LayoutInfo?, uiInfo: UIInfo?) -> Drawing
    
    func create(point: Point?) -> Rectangle
    
    func update(_ drawing: Drawing, rectangle: Rectangle)
    
    func setPresenter(with port: PolygonDrawingPresenterPort)
}
