//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit



class ViewController: UIViewController {
    let viewModel = ViewModel()
    
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
        self.view.addSubview(squareButton)
        self.view.addSubview(lineButton)
        
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
        
        let rect = viewModel.getRect(rect: self.view.frame)
        let rectLayer = makeRectLayer(rect: rect)
        view.layer.addSublayer(rectLayer)
        
        viewModel.appendDrawing(layer: rectLayer)
    }
    
    @objc
    private func didTapLineButton() {
        self.viewModel.drawingType = .line
        squareButton.configure(isSelected: false)
        lineButton.configure(isSelected: true)
    }
    
    // presenter? 같은걸로 빼기
    private func makeRectLayer(rect: CGRect) -> CAShapeLayer {
        let leftTop = CGPoint(x: rect.origin.x, y: rect.origin.y)
        let leftBottom = CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height)
        let rightBottom = CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height)
        let rightTop = CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y)
        
        let path = UIBezierPath()
        UIColor.systemRed.set()
        path.move(to: leftTop)
        path.addLine(to: leftBottom)
        path.addLine(to: rightBottom)
        path.addLine(to: rightTop)
        path.addLine(to: leftTop)
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.randomSystemColor().cgColor
        
        return shapeLayer
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self.view) else { return }
        
        switch viewModel.drawingType {
        case .square:
            viewModel.processRectSelection(point: point)
        case .line:
            let layer = viewModel.startLineDrawing(point: point)
            self.view.layer.addSublayer(layer)
        case .none:
            return
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self.view) else { return }
        
        if viewModel.drawingType == .line {
            viewModel.updateLinePath(point: point)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if viewModel.drawingType == .line {
            viewModel.endLineDrawing()
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
