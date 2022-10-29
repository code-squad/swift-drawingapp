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
    private let syncButton = DrawingTypeButton(title: "동기화")
    
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
        self.view.addSubview(syncButton)
        
        canvasView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        canvasView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        squareButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        squareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        squareButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        squareButton.trailingAnchor.constraint(equalTo: self.lineButton.leadingAnchor).isActive = true
        
        lineButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        lineButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lineButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        lineButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        syncButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        syncButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        syncButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        syncButton.leadingAnchor.constraint(equalTo: self.lineButton.trailingAnchor).isActive = true
    }
}

// MARK: - INPUT
extension DrawingViewController {
    func bindingButtonAction() {
        squareButton.addTarget(self, action: #selector(didTapSquareButton), for: .touchUpInside)
        lineButton.addTarget(self, action: #selector(didTapLineButton), for: .touchUpInside)
        syncButton.addTarget(self, action: #selector(didTapSyncButton), for: .touchUpInside)
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
    
    @objc func didTapSyncButton() {
        let alert = UIAlertController(title: "로그인", message: "id를 입력해주세요", preferredStyle: .alert)
        alert.addTextField()
        let ok  = UIAlertAction(title: "로그인", style: .default) { [weak self] _ in
            guard let id = alert.textFields?[0].text else {
                return
            }
            self?.viewModel.connectServer(id: id)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - OUTPUT
extension DrawingViewController: ViewModelDelegate {
    func drawSquare(square: Square, color: ColorAssets) {
        let layer = drawingLayerMaker.makeSquareLayer(square: square, color: color)
        self.canvasView.layer.addSublayer(layer)
    }
    
    func drawLine(line: Line, color: ColorAssets) {
        let layer = drawingLayerMaker.makeLineLayer(line: line, color: color)
        self.canvasView.layer.addSublayer(layer)
    }
    
    func startLineDraw(line: Line, color: ColorAssets) {
        // guard문 없앨 방법 고민
        guard let layer = drawingLayerMaker.startLineDrawing(line: line, color: color) else {
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
