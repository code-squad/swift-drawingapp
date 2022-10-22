//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

class DrawingViewController: UIViewController {
    
    private var viewModel: DrawingViewModelProtocol
    private let drawingLayerMaker: DrawingLayerMakerProtocol
    
    private let canvasView = CanvasView()
    private let squareButton = DrawingTypeButton(title: "사각형")
    private let lineButton = DrawingTypeButton(title: "직선")
    
    init(
        drawingLayerMaker: DrawingLayerMakerProtocol,
        viewModel: DrawingViewModelProtocol
    ) {
        self.drawingLayerMaker = drawingLayerMaker
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        viewModel.delegate = self
        
        setupView()
        
        bindingCanvasTouch()
        bindingButtonAction()
    }
    
    private func setupView() {
        self.view.addSubview(canvasView)
        self.view.addSubview(squareButton)
        self.view.addSubview(lineButton)
        
        canvasView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        canvasView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        squareButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        squareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        squareButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        squareButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -35).isActive = true
        
        lineButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        lineButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lineButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        lineButton.leadingAnchor.constraint(equalTo: squareButton.trailingAnchor).isActive = true
    }
}

// MARK: - INPUT
extension DrawingViewController {
    func bindingButtonAction() {
        squareButton.addTarget(self, action: #selector(didTapSquareButton), for: .touchUpInside)
        lineButton.addTarget(self, action: #selector(didTapLineButton), for: .touchUpInside)
    }
    
    func bindingCanvasTouch() {
        canvasView.touchBeganCompletion = { [weak self] point in
            self?.viewModel.handleTouchesBegan(point: point)
        }
        canvasView.touchMovedCompletion = { [weak self] point in
            self?.viewModel.handleTouchesMoved(point: point)
        }
        canvasView.touchEndedCompletion = { [weak self] in
            self?.viewModel.handleTouchesEnded()
        }
    }
    
    @objc
    private func didTapSquareButton() {
        viewModel.handleSquareButtonSelected(rect: self.canvasView.frame)
    }
    
    @objc
    private func didTapLineButton() {
        viewModel.handleLineButtonSelected()
    }
}

// MARK: - OUTPUT
extension DrawingViewController: ViewModelDelegate {
    func drawSquare(square: Square) {
        let layer = drawingLayerMaker.makeSquareLayer(square: square)
        self.canvasView.layer.addSublayer(layer)
    }
    
    func startLineDraw(line: Line) {
        // guard문 없앨 방법 고민
        guard let layer = drawingLayerMaker.startLineDrawing(line: line) else {
            return
        }
        self.canvasView.layer.addSublayer(layer)
    }
    
    func updateLineDraw(point: CGPoint) {
        drawingLayerMaker.updateLinePath(point: point)
    }
    
    func endLineDraw() {
        drawingLayerMaker.endLineDrawing()
    }
    
    func selectSquare(square: Square) {
        canvasView.selectSquare(square: square)
    }
}

extension UIColor {
    func randomSystemColor() -> UIColor {
        let colors: [UIColor] = [.systemBlue, .systemCyan, .systemCyan, .systemBrown, .systemIndigo, .systemPurple, .systemTeal, .systemYellow, .systemMint]
        
        return colors.randomElement() ?? self
    }
}
