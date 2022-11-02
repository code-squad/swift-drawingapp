//
//  CanvasViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit
import Combine

final class CanvasViewController: UIViewController {
    private let btnContainer: UIStackView = {
        var stackView: UIStackView = .init()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    private let rectangleButton: UIButton = .create(title: "사각형", selector: #selector(drawRect))
    private let drawingButton: UIButton = .create(title: "드로잉", selector: #selector(beginDrawing))
    private let syncButton: UIButton = .create(title: "동기화", selector: #selector(syncAll))

    private var cancellables: Set<AnyCancellable> = []

    private var pictureViews: [PictureView] = []

    private var port: (DrawPresenterInPort & TouchPresenterInPort & SyncPresenterInPort)?

    func setPort(_ port: (DrawPresenterInPort & TouchPresenterInPort & SyncPresenterInPort)) {
        self.port = port
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnContainer)
        btnContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            btnContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        btnContainer.addArrangedSubview(rectangleButton)
        btnContainer.addArrangedSubview(drawingButton)
        btnContainer.addArrangedSubview(syncButton)
    }

    @objc
    private func drawRect() {
        port?.drawRectangle(inside: .init(
            origin: .init(
                x: Double(view.frame.minX),
                y: Double(view.frame.minY)
            ),
            size: .init(
                width: Double(view.frame.width),
                height: Double(view.frame.height)
            )
        ))
    }

    @objc
    private func beginDrawing() {
        port?.readyDrawingCanvas()
    }

    @objc
    private func syncAll() {
        port?.syncAll()
    }
}

extension CanvasViewController: DrawUIOutPort {
    func drawRectangle(with viewModel: RectangleViewModel) {
        let v = RectangleView(
            frame: CGRect.create(with: viewModel.points.map { CGPoint(x: $0.x, y: $0.y) }),
            color: UIColor.system(viewModel.color),
            lineWidth: CGFloat(viewModel.lineWidth),
            port: self
        )
        pictureViews.append(v)

        viewModel.pointPublisher
            .sink(receiveValue: v.selected)
            .store(in: &cancellables)

        self.view.addSubview(v)
        self.view.bringSubviewToFront(self.btnContainer)
    }

    func readyDrawingCanvas(with viewModel: DrawingViewModel) {
        let v = DrawingView(
            frame: view.frame,
            color: UIColor.system(viewModel.color),
            lineWidth: CGFloat(viewModel.lineWidth),
            port: self
        )
        pictureViews.append(v)

        viewModel.pointPublisher
            .sink(receiveValue: v.selected)
            .store(in: &cancellables)

        self.view.addSubview(v)
        self.view.bringSubviewToFront(self.btnContainer)
    }
}

extension CanvasViewController: DrawUIInPort {
    func touch(on pictureView: PictureView, at location: CGPoint?) {
        for i in pictureViews.indices {
            let pv = pictureViews[i]
            if pictureView === pv {
                port?.touch(index: i, coordinate: location?.convertToPoint())
            }
        }
    }
}

// MARK: - 하단 선택용 Button
fileprivate extension UIButton {
    static func create(title: String, selector: Selector) -> UIButton {
        let button: UIButton = .init()
        button.setTitle(title, for: .normal)
        button.addTarget(nil, action: selector, for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        return button
    }
}

// MARK: - 포인트 4개로 사각형 만들기
fileprivate extension CGRect {
    static func create(with points: [CGPoint]) -> Self {
        guard points.count == 4 else { return .zero }
        var minX: CGFloat = points[0].x
        var maxX: CGFloat = points[0].x
        var minY: CGFloat = points[0].y
        var maxY: CGFloat = points[0].y
        points.forEach { point in
            minX = min(point.x, minX)
            maxX = max(point.x, maxX)
            minY = min(point.y, minY)
            maxY = max(point.y, maxY)
        }
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
}

// MARK: - CGPoint to Point
fileprivate extension CGPoint {
    func convertToPoint() -> Point {
        Point(x: Double(self.x), y: Double(self.y))
    }
}
