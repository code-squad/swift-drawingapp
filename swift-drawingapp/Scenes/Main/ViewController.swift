//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit
import Combine

class ViewController: UIViewController {
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

    private var paintManager: PaintManager = .init()

    private let rectanglePainter = RectanglePainter()
    private let drawingPainer = DrawingPainter()

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btnContainer)
        btnContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            btnContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        btnContainer.addArrangedSubview(rectangleButton)
        btnContainer.addArrangedSubview(drawingButton)

        setRectangle()
        setDrawing()
    }

    private func setRectangle() {
        paintManager.rectanglePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] rectangle in
                guard
                    let self,
                    let rectangle
                else { return }
                let _view = RectangleView(info: rectangle)

                self.view.addSubview(_view)
                self.view.bringSubviewToFront(self.btnContainer)

                rectangle.isActivePublisher
                    .receive(on: RunLoop.main)
                    .sink(receiveValue: _view.drawBorder)
                    .store(in: &self.cancellables)
            }
            .store(in: &cancellables)
    }

    private func setDrawing() {
        paintManager.drawingPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] drawing in
                guard
                    let self,
                    let drawing
                else { return }
                let _view = DrawingView(info: drawing)
                self.view.addSubview(_view)
                self.view.bringSubviewToFront(self.btnContainer)

                drawing.areaPublisher
                    .receive(on: RunLoop.main)
                    .sink(receiveValue: _view.setFrame)
                    .store(in: &self.cancellables)

                drawing.pointPublisher
                    .receive(on: RunLoop.main)
                    .sink(receiveValue: _view.draw)
                    .store(in: &self.cancellables)

                drawing.isActivePublisher
                    .receive(on: RunLoop.main)
                    .sink(receiveValue: _view.activeControl)
                    .store(in: &self.cancellables)
            }
            .store(in: &cancellables)
    }

    @objc
    private func drawRect() {
        let screenBounds: CGRect = UIScreen.main.bounds
        let screenWidth: CGFloat = screenBounds.width
        let screenHeight: CGFloat = screenBounds.height
        let length: Double = 100
        let randomArea: Area = .init(
            origin: .init(
                x: Double.random(in: 0..<Double(screenWidth)-length),
                y: Double.random(in: 0..<Double(screenHeight)-length)
            ),
            size: .init(width: length, height: length)
        )
        let paint = rectanglePainter.draw(color: Color.randomColor, area: randomArea, lineWidth: 4)
        paintManager.addPaint(paint)
    }

    @objc
    private func beginDrawing() {
        let area: Area = .init(
            origin: .init(
                x: Double(view.frame.minX),
                y: Double(view.frame.minY)
            ),
            size: .init(
                width: Double(view.frame.width),
                height: Double(view.frame.height)
            )
        )
        let paint = drawingPainer.draw(color: Color.randomColor, area: area, lineWidth: 8)
        paintManager.addPaint(paint)
    }
}

// MARK: - 하단 선택용 Button
extension UIButton {
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


