//
//  CanvasViewModelType.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import UIKit

protocol CanvasViewModelType {
    
    var polygonDrawingUseCase: PolygonDrawingUseCase { get }
    
    var inkDrawingUseCase: InkDrawingUseCase { get }
    
    var toolSelectionUseCase: ToolSelectionUseCase { get }
    
    var itemSelectionUseCase: ItemSelectionUseCase { get }
    
    var drawing: Drawing { get }
    
    @discardableResult
    func draw(tool: Tool, layoutInfo: LayoutInfo?, uiInfo: UIInfo?) -> Drawing
    
    @discardableResult
    func draw(tool: Tool, beganAt: Point) -> Drawing
    
    @discardableResult
    func draw(tool: Tool, valueChangedAt: Point) -> Drawing
    
    @discardableResult
    func draw(tool: Tool, endedAt: Point) -> Drawing
    
    @discardableResult
    func select(item: Item) -> Drawing.DataType
    
    @discardableResult
    func select(toolInfo: ToolInfo) -> Tool
    
    @discardableResult
    func find(items: [Item], point: Point) -> Item?
}
