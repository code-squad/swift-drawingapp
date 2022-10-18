//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var canvasView: CanvasView!
    
    @IBOutlet private weak var toolbarView: ToolBarView!
    
    private var selectedTool: Tool = PolygonTool()
    
    private let viewModel: CanvasViewModel
    
    required init?(coder: NSCoder) {
        self.viewModel = CanvasViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


private extension ViewController {
    
    func setup() {
        canvasView.delegate = self
        toolbarView.delegate = self
        viewModel.delegate = self
    }
}


// MARK: - Input

extension ViewController: ToolBarViewDelegate {
    
    func toolBarView(_ toolBarView: ToolBarView, selectedTool: Tool) {
        self.selectedTool = selectedTool
    }
}

extension ViewController: CanvasViewDelegate {
    
    func canvasView(_ canvasView: CanvasView, selectedItem: Item) {
        viewModel.select(item: selectedItem)
    }
    
    func canvasView(_ canvasView: CanvasView, didTapEndedAt: CGPoint) {
        viewModel.draw(tool: selectedTool, layoutInfo: .init(center: didTapEndedAt.toPoint), uiInfo: nil)
    }
    
    func canvasView(_ canvasView: CanvasView, didDragBeganAt: CGPoint) {
        viewModel.draw(tool: selectedTool, beganAt: didDragBeganAt.toPoint)
    }
    
    func canvasView(_ canvasView: CanvasView, didDragValueChangedAt: CGPoint) {
        viewModel.draw(tool: selectedTool, valueChangedAt: didDragValueChangedAt.toPoint)
    }
    
    func canvasView(_ canvasView: CanvasView, didDragEndedAt: CGPoint) {
        viewModel.draw(tool: selectedTool, endedAt: didDragEndedAt.toPoint)
    }
}

// MARK: - Output

extension ViewController: CanvasViewModelDelegate {
    
    func viewModelDidDrawingEnded(_ viewModel: CanvasViewModel, drawing: Drawing) {
        canvasView.update(drawing: drawing)
    }
    
    func viewModelDidSelected(_ viewModel: CanvasViewModel, items: [Item]) {
        canvasView.update(selectedItems: items)
    }
}
