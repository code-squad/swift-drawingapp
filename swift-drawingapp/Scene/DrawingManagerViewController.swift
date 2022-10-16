//
//  DrawingManagerViewController.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import UIKit

class DrawingManagerViewController: UIViewController {
    
    private let drawingManager = DrawingManager()
    
    private lazy var canvasView = {
        let cv = CanvasView(frame: view.bounds)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.setViewModel(.init(canvas: drawingManager.canvas))
        return cv
    }()
    
    private lazy var addRectButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: .init(width: 100, height: 100)))
        button.setTitle("사각형", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private lazy var addDrawingButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: .init(width: 100, height: 100)))
        button.setTitle("드로잉", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupActions()
    }
    
    private func setupViews() {
        view.backgroundColor = .lightGray
        
        let hStack = UIStackView(arrangedSubviews: [addRectButton, addDrawingButton])
        hStack.axis = .horizontal
        hStack.spacing = 10
        
        [canvasView, hStack]
            .forEach { view.addSubview($0) }
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        [
            hStack.bottomAnchor
                .constraint(equalTo: view.bottomAnchor, constant: -100),
            hStack.centerXAnchor
                .constraint(equalTo: view.centerXAnchor)
        ]
            .forEach { $0.isActive = true }
    }
    
    private func setupActions() {
        addRectButton.addTarget(self, action: #selector(addRectButtonTapped), for: .touchUpInside)
        
        addDrawingButton.addTarget(self, action: #selector(addDrawingButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addRectButtonTapped() {
        drawingManager.createRandomRect()
    }
    
    @objc
    private func addDrawingButtonTapped() {
        print("addDrawing")
        
    }
}
