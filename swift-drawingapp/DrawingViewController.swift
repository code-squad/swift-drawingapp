//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import Combine
import UIKit

class DrawingViewController: UIViewController {
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

    private let viewModel: ViewModelProtocol
    private var currentDrawingID: UUID?

    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel

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
        let rect = viewModel.createRect()
        drawRect(rect)
    }

    private func drawRect(_ rect: Rect) {
        let rectView = RectView(
            id: rect.id,
            frame: .init(
                origin: .init(
                    x: rect.position.cgPoint.x * (view.frame.maxX - 100),
                    y: rect.position.cgPoint.y * (buttonStackView.frame.minY - 100)
                ),
                size: rect.size.cgSize
            ),
            color: rect.color.uiColor.withAlphaComponent(0.6)
        )
        rectView.addTarget(self, action: #selector(didTapRectView), for: .touchUpInside)
        view.addSubview(rectView)
    }

    @objc
    private func didTapDrawingButton() {
        let drawing = viewModel.startDrawing()
        currentDrawingID = drawing.id
        drawingCanvasView.drawingColor = drawing.color.uiColor
        drawingCanvasView.enableDrawing()
    }

    @objc
    private func didTapRectView(sender: RectView) {
        sender.isSelected.toggle()
    }
}

extension DrawingViewController: DrawingCanvasViewDelegate {
    func drawingCanvasView(didDrawTo path: CGPoint) {
        guard let id = currentDrawingID else { return }

        viewModel.draw(id: id, path: .init(x: path.x, y: path.y))
    }
}
