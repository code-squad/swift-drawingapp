//
//  CanvasViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

final class CanvasViewController: UIViewController {
    
    @IBOutlet private weak var canvasView: CanvasView!
    
    @IBOutlet private weak var toolbarView: ToolBarView!
    
    private var selectedTool: Tool = PolygonTool()
    
    private var viewModel: CanvasViewModelType
    
    init?(coder: NSCoder, viewModel: CanvasViewModelType) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


private extension CanvasViewController {
    
    func setup() {
        canvasView.delegate = self
        toolbarView.delegate = self
    }
}

extension CanvasViewController: ToolBarViewDelegate {
    
    func toolBarView(_ toolBarView: ToolBarView, selectedToolInfo: ToolInfo) {
        selectedTool = viewModel.select(toolInfo: selectedToolInfo)
    }
}

extension CanvasViewController: CanvasViewDelegate {
    
    func canvasView(_ canvasView: CanvasView, selectedItem: Item) {
        let items = viewModel.select(item: selectedItem)
        canvasView.update(selectedItems: items)
    }
    
    func canvasView(_ canvasView: CanvasView, didTapEndedAt: CGPoint) {
        let rectangles = canvasView.subviews
            .reversed()
            .compactMap {
                Rectangle(id: ($0 as? RectangleView)?.uuidString ?? UUID().uuidString, layoutInfo: LayoutInfo($0), uiInfo: UIInfo($0))
            }
        if let item = viewModel.find(items: rectangles, point: didTapEndedAt.toPoint) {
            canvasView.update(selectedItems: viewModel.select(item: item))
        } else {
            let drawing = viewModel.draw(tool: selectedTool, layoutInfo: .init(center: didTapEndedAt), uiInfo: nil)
            canvasView.update(drawing: drawing)
        }
    }
    
    func canvasView(_ canvasView: CanvasView, didDragBeganAt: CGPoint) {
        let drawing = viewModel.draw(tool: selectedTool, beganAt: didDragBeganAt.toPoint)
        canvasView.update(drawing: drawing)
    }
    
    func canvasView(_ canvasView: CanvasView, didDragValueChangedAt: CGPoint) {
        let drawing = viewModel.draw(tool: selectedTool, valueChangedAt: didDragValueChangedAt.toPoint)
        canvasView.update(drawing: drawing)
    }
    
    func canvasView(_ canvasView: CanvasView, didDragEndedAt: CGPoint) {
        let drawing = viewModel.draw(tool: selectedTool, endedAt: didDragEndedAt.toPoint)
        canvasView.update(drawing: drawing)
    }
}
