//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit
import Combine

final class ViewController: UIViewController {

    @IBOutlet private weak var addRectangleButton: UIButton!
    @IBOutlet private weak var drawingButton: UIButton!
    @IBOutlet private weak var canvasView: UIView!
    @IBOutlet private weak var indicatorLabel: UILabel!

    private var canvasViewPanGesturePublisher = PassthroughSubject<UIPanGestureRecognizer, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var pathShape: PathShape? {
        didSet {
            guard let pathShape = pathShape,
                  pathShape.paths.isEmpty else {
                      indicatorLabel.isHidden = true
                      return
                }
            indicatorLabel.isHidden = false
        }
    }

    private let viewModel: ViewModel

    init(viewModel: ViewModel, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    init?(coder: NSCoder, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("This viewController must be init with viewModel")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonAction()
        configureView()
        configurePublisher()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.state.canvasRect
            .send(canvasView.bounds)
    }

}

private extension ViewController {

    func bindViewModel() {
        viewModel.state
            .drawingObjects
            .receive(on: DispatchQueue.main)
            .sink { [weak self] objects in
                self?.clearCanvasUI()
                self?.addUI(with: objects)
            }
            .store(in: &cancellables)
    }

    func addUI(with objects: [DrawingObject]) {
        objects.forEach { object in
            switch object {
            case let rectangle as Rectangle:
                addRectangleUI(rectangle)
            case let pathShape as PathShape:
                addPathShapeUI(pathShape)
            default:
                break
            }
        }
    }

    func clearCanvasUI() {
        canvasView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }

    func addRectangleUI(_ rectangle: Rectangle) {
        let rectangleView = RectangleView(rectangle)

        rectangleView.tapPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.viewModel.action.selectObject.send(rectangle)
            })
            .store(in: &rectangleView.cancellables)

        self.canvasView.addSubview(rectangleView)
    }

    func addPathShapeUI(_ pathShape: PathShape) {
        let pathShapeView = PathShapeView(pathShape)

        pathShapeView.tapPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.viewModel.action.selectObject.send(pathShape)
            })
            .store(in: &pathShapeView.cancellables)

        self.canvasView.addSubview(pathShapeView)
    }

    func configureView() {
        indicatorLabel.isHidden = true
        canvasView.backgroundColor = .black.withAlphaComponent(0.05)

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(touchedScreen(gesture:)))
        canvasView.addGestureRecognizer(gesture)
    }

    func configurePublisher() {
        canvasViewPanGesturePublisher
            .sink { [weak self] recognizer in
                guard let self = self else { return }
                let touchPoint = recognizer.location(in: self.canvasView)

                guard var pathShape = self.pathShape else { return }
                switch recognizer.state {
                case .began:
                    self.viewModel.action.addObject.send(pathShape)
                    self.indicatorLabel.isHidden = true
                case .changed:
                    pathShape.paths.append(touchPoint)
                    self.pathShape = pathShape
                    self.viewModel.action.addObject.send(pathShape)
                case .ended:
                    let pathsX = pathShape.paths.map { $0.x }
                    let pathsY = pathShape.paths.map { $0.y }

                    let minX = pathsX.min() ?? 0
                    let maxX = pathsX.max() ?? 0
                    let minY = pathsY.min() ?? 0
                    let maxY = pathsY.max() ?? 0

                    pathShape.paths = pathShape.paths.map { point in
                        return CGPoint(x: point.x - minX, y: point.y - minY)
                    }
                    pathShape.origin = CGPoint(x: minX, y: minY)
                    pathShape.size = CGSize(width: maxX - minX, height: maxY - minY)
                    self.viewModel.action.addObject.send(pathShape)
                    self.pathShape = nil

                default:
                    break
                }

            }.store(in: &cancellables)
    }

    func configureButtonAction() {
        let gestureForRect = UITapGestureRecognizer()
        gestureForRect.addTarget(self, action: #selector(didTapAddRectangleButton(_:)))
        addRectangleButton.addGestureRecognizer(gestureForRect)

        let gestureForDraw = UITapGestureRecognizer()
        gestureForDraw.addTarget(self, action: #selector(didTapDrawingButton(_:)))
        drawingButton.addGestureRecognizer(gestureForDraw)
    }

    @objc func touchedScreen(gesture: UIPanGestureRecognizer) {

        canvasViewPanGesturePublisher.send(gesture)
    }

    @objc func didTapAddRectangleButton(_ sender: UITapGestureRecognizer) {
        viewModel.action
            .addRectangle
            .send(())
    }

    @objc func didTapDrawingButton(_ sender: UITapGestureRecognizer) {
        pathShape = PathShape(origin: self.canvasView.bounds.origin, size: self.canvasView.bounds.size, color: .randomColor, paths: [])
    }
}
