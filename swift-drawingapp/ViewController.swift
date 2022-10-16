//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    private let rectButton: RectButton = .init()
    private let drawingButton: DrawingButton = .init()
    private let drawingCanvasView: DrawingCanvasView = {
        let view = DrawingCanvasView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let rectProvider: RectProvidable
    let drawingHandler: DrawingHandleable
    var isDrawing: Bool = false

    init(rectProvider: RectProvidable, drawingHandler: DrawingHandleable) {
        self.rectProvider = rectProvider
        self.drawingHandler = drawingHandler

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    private func setUI() {
        view.backgroundColor = .white

        view.addSubview(drawingCanvasView)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(rectButton)
        buttonStackView.addArrangedSubview(drawingButton)

        NSLayoutConstraint.activate([
            drawingCanvasView.topAnchor.constraint(equalTo: view.topAnchor),
            drawingCanvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drawingCanvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drawingCanvasView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        rectButton.addTarget(self, action: #selector(didTapRectButton), for: .touchUpInside)
        drawingButton.addTarget(self, action: #selector(didTapDrawingButton), for: .touchUpInside)
        drawingCanvasView.delegate = self
    }

    @objc
    private func didTapRectButton() {
        addRectView()
    }

    private func addRectView() {
        let rect = rectProvider.createRect()

        let rectView = RectView(id: rect.id)
        rectView.frame = .init(
            origin: .random(in: view.frame),
            size: .init(width: 100, height: 100)
        )
        rectView.backgroundColor = .random
        rectView.addTarget(self, action: #selector(didTapRectView), for: .touchUpInside)
        view.addSubview(rectView)
    }

    @objc
    private func didTapDrawingButton() {
        drawingCanvasView.enableDrawing()
    }

    @objc
    private func didTapRectView(sender: RectView) {
        sender.isSelected.toggle()
    }
}

extension ViewController: DrawingCanvasViewDelegate {
    func drawingCanvasView(didDrawTo path: CGPoint, state: DrawingCanvasView.DrawingState) {
        switch state {
        case .began:
            drawingHandler.startDrawing()
            drawingHandler.draw(path: .init(x: path.x, y: path.y))
        case .onGoing:
            drawingHandler.draw(path: .init(x: path.x, y: path.y))
        case .ended:
            drawingHandler.endDrawing()
        }
    }
}
