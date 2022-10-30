//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import Combine
import UIKit

protocol DrawingViewInputHandleable {
    func didTapCreateRectButton()
    func didTapDrawingButton()
    func draw(to path: DrawingPath)
    func endDrawing()
}

protocol DrawingViewOutputHandleable {
    var rectsPublisher: AnyPublisher<[Rect], Never> { get }
    var currentDrawingColorPublisher: AnyPublisher<DrawingColor, Never> { get }
    var drawingsPublisher: AnyPublisher<[Drawing], Never> { get }
}

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

    private let inputHandler: DrawingViewInputHandleable
    private let outputHandler: DrawingViewOutputHandleable
    private var cancelBag: Set<AnyCancellable>

    init(
        inputHandler: DrawingViewInputHandleable,
        outputHandler: DrawingViewOutputHandleable
    ) {
        self.inputHandler = inputHandler
        self.outputHandler = outputHandler
        cancelBag = .init()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bind()
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

    private func bind() {
        outputHandler.rectsPublisher
            .subscribe(on: DispatchQueue.main)
            .sink { rects in
                rects.forEach {
                    self.drawRect($0)
                }
            }
            .store(in: &cancelBag)

        outputHandler.currentDrawingColorPublisher
            .subscribe(on: DispatchQueue.main)
            .sink { color in
                self.drawingCanvasView.drawingColor = color.uiColor
                self.drawingCanvasView.enableDrawing()
            }
            .store(in: &cancelBag)

        outputHandler.drawingsPublisher
            .subscribe(on: DispatchQueue.main)
            .sink { drawings in
                drawings.forEach {
                    self.drawingCanvasView.addDrawing($0)
                }
            }
            .store(in: &cancelBag)
    }

    @objc
    private func didTapRectButton() {
        inputHandler.didTapCreateRectButton()
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
        inputHandler.didTapDrawingButton()
    }

    @objc
    private func didTapRectView(sender: RectView) {
        sender.isSelected.toggle()
    }
}

extension DrawingViewController: DrawingCanvasViewDelegate {
    func drawingCanvasView(didDrawTo path: CGPoint) {
        inputHandler.draw(to: .init(x: path.x, y: path.y))
    }

    func endDrawing() {
        inputHandler.endDrawing()
    }
}
