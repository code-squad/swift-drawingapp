//
//  DrawingAppViewController.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import UIKit

class DrawingAppViewController: UIViewController {
    
    private var driver: DrawingAppDriving!
    
    private lazy var canvasView: CanvasView = {
        let cv = CanvasView(frame: view.bounds)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.setCanvasModel(driver.canvasViewRepresenter)
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
    
    private lazy var syncButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: .init(width: 100, height: 100)))
        button.setTitle("동기화", for: .normal)
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
        
        let hStack = UIStackView(arrangedSubviews: [
            addRectButton, addDrawingButton, syncButton
        ])
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
        
        syncButton.addTarget(self, action: #selector(syncButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapPoint))
        canvasView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Setter
    
    func setAppDriver(_ driver: DrawingAppDriving) {
        self.driver = driver
    }
    
    @objc
    private func addRectButtonTapped() {
        driver.createRandomRect()
    }
    
    @objc
    private func tapPoint(_ tapGesture: UITapGestureRecognizer) {
        let point = tapGesture.location(in: canvasView)
        driver.selectShape(at: point)
    }
    
    // MARK: - 패스 드로잉
    
    private var pointContinuation: AsyncStream<CGPoint>.Continuation?

    private lazy var panGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        panGesture.isEnabled = false
        canvasView.addGestureRecognizer(panGesture)
        return panGesture
    }()
    @objc
    private func addDrawingButtonTapped() {
        let stream = AsyncStream<CGPoint> { pointContinuation = $0 }
        driver.drawPath(cgPointStream: stream.eraseToAnyAsyncSequence())
        panGesture.isEnabled = true
    }
    
    @objc
    private func didPan(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began, .changed:
            let point = panGesture.location(in: canvasView)
            pointContinuation?.yield(point)
        default:
            panGesture.isEnabled = false
            pointContinuation?.finish()
            pointContinuation = nil
        }
    }
    
    @objc
    private func syncButtonTapped() {
        driver.startSync()
    }
}
