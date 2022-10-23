//
//  CanvasViewModel.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/18.
//

import Foundation

class CanvasViewModel: CanvasViewModelType {
    
    let polygonDrawingUseCase: PolygonDrawingUseCase
    
    let inkDrawingUseCase: InkDrawingUseCase
    
    let toolSelectionUseCase: ToolSelectionUseCase
    
    let itemSelectionUseCase: ItemSelectionUseCase
    
    private(set) var drawing: Drawing
    
    init(
        drawing: Drawing = .init(),
        polygonDrawingUseCase: PolygonDrawingUseCase,
        inkDrawingUseCase: InkDrawingUseCase,
        toolSelectionUseCase: ToolSelectionUseCase,
        itemSelectionUseCase: ItemSelectionUseCase
    ) {
        self.drawing = drawing
        self.polygonDrawingUseCase = polygonDrawingUseCase
        self.inkDrawingUseCase = inkDrawingUseCase
        self.toolSelectionUseCase = toolSelectionUseCase
        self.itemSelectionUseCase = itemSelectionUseCase
    }
    
    func draw(tool: Tool, layoutInfo: LayoutInfo?, uiInfo: UIInfo?) -> Drawing {
        guard tool is PolygonTool else { return drawing }
        polygonDrawingUseCase.update(drawing, rectangle: polygonDrawingUseCase.create(point: layoutInfo?.center?.toPoint))
        return drawing
    }
    
    func draw(tool: Tool, beganAt: Point) -> Drawing {
        guard let inkTool = tool as? InkTool else { return drawing }
        inkDrawingUseCase.update(drawing, stroke: inkDrawingUseCase.create(positions: [beganAt], ink: inkTool.ink))
        return drawing
    }
    
    func draw(tool: Tool, valueChangedAt: Point) -> Drawing {
        guard tool is InkTool, let stroke = inkDrawingUseCase.currentDrawingStroke else { return drawing }
        inkDrawingUseCase.update(drawing, stroke: stroke, points: [valueChangedAt])
        return drawing
    }
    
    func draw(tool: Tool, endedAt: Point) -> Drawing {
        guard tool is InkTool, let stroke = inkDrawingUseCase.currentDrawingStroke else { return drawing }
        inkDrawingUseCase.update(drawing, stroke: stroke, points: [endedAt])
        inkDrawingUseCase.reset()
        return drawing
    }
    
    func select(item: Item) -> Drawing.DataType {
        return itemSelectionUseCase.select(drawing, item: item)
    }
    
    func select(toolInfo: ToolInfo) -> Tool {
        return toolSelectionUseCase.create(toolInfo: toolInfo)
    }
    
    func find(items: [Item], point: Point) -> Item? {
        itemSelectionUseCase.find(items: items, point: point)
    }
}
