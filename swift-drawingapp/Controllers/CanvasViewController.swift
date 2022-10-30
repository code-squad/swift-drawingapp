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
    
    private let polygonDrawingUseCase: PolygonDrawingUseCase
    
    private let inkDrawingUseCase: InkDrawingUseCase
    
    private let toolSelectionUseCase: ToolSelectionUseCase
    
    private let itemSelectionUseCase: ItemSelectionUseCase
    
    private let drawingOrSelectionUseCase: SelectionOrDrawingUseCase
    
    private let syncUseCase: SyncUseCase
    
    init?(
        coder: NSCoder,
        polygonDrawingUseCase: PolygonDrawingUseCase,
        inkDrawingUseCase: InkDrawingUseCase,
        toolSelectionUseCase: ToolSelectionUseCase,
        itemSelectionUseCase: ItemSelectionUseCase,
        drawingOrSelectionUseCase: SelectionOrDrawingUseCase,
        syncUseCase: SyncUseCase
    ) {
        self.polygonDrawingUseCase = polygonDrawingUseCase
        self.inkDrawingUseCase = inkDrawingUseCase
        self.toolSelectionUseCase = toolSelectionUseCase
        self.itemSelectionUseCase = itemSelectionUseCase
        self.drawingOrSelectionUseCase = drawingOrSelectionUseCase
        self.syncUseCase = syncUseCase
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
        // Input
        canvasView.delegate = self
        toolbarView.delegate = self
        
        // Output
        polygonDrawingUseCase.setPresenter(with: self)
        inkDrawingUseCase.setPresenter(with: self)
        toolSelectionUseCase.setPresenter(with: self)
        itemSelectionUseCase.setPresenter(with: self)
    }
    
    func presentLoginViewController() {
        guard let viewController = UIStoryboard(name: "LoginViewController", bundle: .main).instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        viewController.delegate = self
        present(viewController, animated: true)
    }
}

// MARK: - LoginViewControllerDelegate

extension CanvasViewController: LoginViewControllerDelegate {
    
    func loginViewController(_ viewController: LoginViewController, loginWithID: String) {
        syncUseCase.login(user: syncUseCase.create(id: loginWithID), drawing: polygonDrawingUseCase.drawing)
        syncUseCase.start(by: syncUseCase.currentLoggedInUser)
    }
}

// MARK: - ToolBarViewDelegate

extension CanvasViewController: ToolBarViewDelegate {
    
    func toolBarView(_ toolBarView: ToolBarView, selectedToolInfo: ToolInfo) {
        toolSelectionUseCase.select(toolInfo: selectedToolInfo)
    }
}

// MARK: - CanvasViewDelegate

extension CanvasViewController: CanvasViewDelegate {
    
    func canvasView(_ canvasView: CanvasView, selectedItem: Item) {
        itemSelectionUseCase.select(itemSelectionUseCase.drawing, item: selectedItem)
    }
    
    func canvasView(_ canvasView: CanvasView, didTapEndedAt: CGPoint) {
        let rectangles = canvasView.subviews.reversed()
            .compactMap { Rectangle(id: ($0 as? RectangleView)?.uuidString ?? UUID().uuidString, layoutInfo: LayoutInfo($0), uiInfo: UIInfo($0)) }
        drawingOrSelectionUseCase.selectOrDraw(items: rectangles, point: didTapEndedAt.toPoint)
    }
    
    func canvasView(_ canvasView: CanvasView, didDragBeganAt: CGPoint) {
        inkDrawingUseCase.draw(tool: inkDrawingUseCase.selectedTool, beganAt: didDragBeganAt.toPoint)
    }
    
    func canvasView(_ canvasView: CanvasView, didDragValueChangedAt: CGPoint) {
        inkDrawingUseCase.draw(tool: inkDrawingUseCase.selectedTool, valueChangedAt: didDragValueChangedAt.toPoint)
    }
    
    func canvasView(_ canvasView: CanvasView, didDragEndedAt: CGPoint) {
        inkDrawingUseCase.draw(tool: inkDrawingUseCase.selectedTool, endedAt: didDragEndedAt.toPoint)
    }
}


// MARK: - PolygonDrawingPort, InkDrawingPort

extension CanvasViewController: PolygonDrawingPresenterPort, InkDrawingPresenterPort {
    
    func update(drawing: Drawing) {
        canvasView.update(drawing: drawing)
    }
}

// MARK: - ToolSelectionPort

extension CanvasViewController: ToolSelectionPresenterPort {
    
    func update(tool: Tool) {
        switch tool.self {
        case is SyncTool:
            presentLoginViewController()
            
        default:
            break
        }
    }
}

// MARK: - ItemSelectionPort

extension CanvasViewController: ItemSelectionPresenterPort {
    
    func update(selectedItems: Drawing.DataType) {
        canvasView.update(selectedItems: selectedItems)
    }
}
