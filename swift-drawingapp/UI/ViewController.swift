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

    private var cancellables = Set<AnyCancellable>()

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

    func updatePathShapeUI(drawing: PathShape) {
        // TODO
    }

    func configureView() {
        canvasView.backgroundColor = .black.withAlphaComponent(0.05)
    }

    func configureButtonAction() {
        let gestureForRect = UITapGestureRecognizer()
        gestureForRect.addTarget(self, action: #selector(didTapAddRectangleButton(_:)))
        addRectangleButton.addGestureRecognizer(gestureForRect)

        let gestureForDraw = UITapGestureRecognizer()
        gestureForDraw.addTarget(self, action: #selector(didTapDrawingButton(_:)))
        drawingButton.addGestureRecognizer(gestureForDraw)
    }

    @objc func didTapAddRectangleButton(_ sender: UITapGestureRecognizer) {
        viewModel.action
            .addRectangle
            .send(())
    }

    @objc func didTapDrawingButton(_ sender: UITapGestureRecognizer) {

    }
}
