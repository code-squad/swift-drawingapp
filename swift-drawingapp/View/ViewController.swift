//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit



class ViewController: UIViewController {
    let viewModel = ViewModel()
    
    private let canvasView = CanvasView()
    private let squareButton = DrawingTypeButton(title: "사각형")
    private let lineButton = DrawingTypeButton(title: "직선")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setupView()
        
        squareButton.addTarget(self, action: #selector(didTapSquareButton), for: .touchUpInside)
        lineButton.addTarget(self, action: #selector(didTapLineButton), for: .touchUpInside)
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

    @objc
    private func didTapSquareButton() {
        self.viewModel.drawingType = .square
        squareButton.configure(isSelected: true)
        lineButton.configure(isSelected: false)
        
        let layer = canvasView.addSquareLayer()
        
        viewModel.appendDrawing(layer: layer)
    }
    
    @objc
    private func didTapLineButton() {
        self.viewModel.drawingType = .line
        squareButton.configure(isSelected: false)
        lineButton.configure(isSelected: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self.canvasView) else { return }
        
        switch viewModel.drawingType {
        case .square:
            viewModel.processRectSelection(point: point)
        case .line:
            canvasView.startLineDrawing(point: point)
        case .none:
            return
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self.canvasView) else { return }
        
        if viewModel.drawingType == .line {
            canvasView.updateLinePath(point: point)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if viewModel.drawingType == .line {
            let lineLayer = canvasView.endLineLayer()
            viewModel.appendDrawing(layer: lineLayer)
        }
    }
}

extension ViewController: ViewModelDelegate {
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
