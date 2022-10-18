//
//  CanvasViewModel.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/18.
//

import Foundation

protocol CanvasViewModelDelegate: AnyObject {
    
    func viewModelDidDrawingEnded(_ viewModel: CanvasViewModel, drawing: Drawing)
    
    func viewModelDidSelected(_ viewModel: CanvasViewModel, items: [Item])
}

class CanvasViewModel {
    
    let polygonDrawingUseCase: PolygonDrawingUseCase
    
    let inkDrawingUseCase: InkDrawingUseCase
    
    weak var delegate: CanvasViewModelDelegate?
    
    var drawing: Drawing
    
    var currentDrawingStroke: Stroke?
    
    init(
        drawing: Drawing = .init(),
        polygonDrawingUseCase: PolygonDrawingUseCase = PolygonDrawingUseCaseImpl(),
        inkDrawingUseCase: InkDrawingUseCase = InkDrawingUseCaseImpl()
    ) {
        self.drawing = drawing
        self.polygonDrawingUseCase = polygonDrawingUseCase
        self.inkDrawingUseCase = inkDrawingUseCase
    }
    
    func draw(tool: Tool, layoutInfo: LayoutInfo?, uiInfo: UIInfo?) {
        guard tool is PolygonTool else { return }
        drawing.items.append(polygonDrawingUseCase.create(point: layoutInfo?.center ?? .zero))
        delegate?.viewModelDidDrawingEnded(self, drawing: drawing)
    }
    
    func draw(tool: Tool, beganAt: Point) {
        guard let inkTool = tool as? InkTool else { return }
        let newStroke = inkDrawingUseCase.create(positions: [beganAt], ink: inkTool.ink)
        drawing.items.append(newStroke)
        currentDrawingStroke = newStroke
        delegate?.viewModelDidDrawingEnded(self, drawing: drawing)
    }
    
    func draw(tool: Tool, valueChangedAt: Point) {
        guard let inkTool = tool as? InkTool,
              let idx = drawing.items.firstIndex(where: { $0.id == currentDrawingStroke?.id }),
              let stroke = drawing.items[idx] as? Stroke else { return }
        let newStroke = Stroke(
            id: stroke.id,
            positions: stroke.points.compactMap { $0 } + [valueChangedAt],
            ink: inkTool.ink
        )
        drawing.items[idx] = newStroke
        currentDrawingStroke = newStroke
        delegate?.viewModelDidDrawingEnded(self, drawing: drawing)
    }
    
    func draw(tool: Tool, endedAt: Point) {
        guard let inkTool = tool as? InkTool,
              let idx = drawing.items.firstIndex(where: { $0.id == currentDrawingStroke?.id }),
              let stroke = drawing.items[idx] as? Stroke else { return }
        drawing.items[idx] = Stroke(
            id: stroke.id,
            positions: stroke.points.compactMap { $0 } + [endedAt],
            ink: inkTool.ink
        )
        currentDrawingStroke = nil
        delegate?.viewModelDidDrawingEnded(self, drawing: drawing)
    }
    
    func select(item: Item) {
        if !drawing.selectedItems.contains(where: { $0.id == item.id }) {
            drawing.selectedItems.append(item)
        } else {
            if let idx = drawing.selectedItems.firstIndex(where: { $0.id == item.id }) {
                drawing.selectedItems.remove(at: idx)
            }
        }
        delegate?.viewModelDidSelected(self, items: drawing.selectedItems)
    }
}
