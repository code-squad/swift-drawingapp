//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit



class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private let drawingMaker = DrawingMaker()
    
    private let canvasView = CanvasView()
    private let squareButton = DrawingTypeButton(title: "사각형")
    private let lineButton = DrawingTypeButton(title: "직선")
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension ViewController {
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
        viewModel.handleButtonSelected(type: .square)
    }
    
    @objc
    private func didTapLineButton() {
        viewModel.handleButtonSelected(type: .line)
    }
}

// MARK: - OUTPUT
extension ViewController: ViewModelDelegate {
    func squareButtonSelected() {
        squareButton.configure(isSelected: true)
        lineButton.configure(isSelected: false)
        
        let layer = drawingMaker.getSquareLayer(rect: self.canvasView.frame)
        self.canvasView.layer.addSublayer(layer)
        
        viewModel.appendDrawing(layer: layer)
    }
    
    func lineButtonSelected() {
        squareButton.configure(isSelected: false)
        lineButton.configure(isSelected: true)
    }
    
    func startLineDrawing(point: CGPoint) {
        drawingMaker.startLineDrawing(point: point)
        let layer = drawingMaker.getlineLayer()
        self.canvasView.layer.addSublayer(layer)
    }
    
    func updateLineDrawing(point: CGPoint) {
        drawingMaker.updateLinePath(point: point)
    }
    
    func endLineDrawing() {
        let lineLayer = drawingMaker.getlineLayer()
        viewModel.appendDrawing(layer: lineLayer)
    }
    
    func rectSelected(layer: CAShapeLayer) {
        layer.lineWidth = 3
        layer.strokeColor = UIColor.systemRed.cgColor
        self.view.setNeedsLayout()
    }
    
    func rectSelectedAgain(layer: CAShapeLayer) {
        layer.lineWidth = 0
        layer.strokeColor = UIColor.clear.cgColor
        self.view.setNeedsLayout()
    }
}

extension UIColor {
    func randomSystemColor() -> UIColor {
        let colors: [UIColor] = [.systemBlue, .systemCyan, .systemCyan, .systemBrown, .systemIndigo, .systemPurple, .systemTeal, .systemYellow, .systemMint]
        
        return colors.randomElement() ?? self
    }
}
