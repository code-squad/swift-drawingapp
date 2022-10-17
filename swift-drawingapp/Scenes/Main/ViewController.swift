//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

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
    private var paintStorage: PaintStorage = .init()

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
        let _view = RectangleView(info: paintStorage.addRectangle(area: randomArea))
        view.addSubview(_view)
        view.bringSubviewToFront(btnContainer)
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
        let _view = DrawingView(info: paintStorage.addDrawing(lineWidth: 8, area: area))
        view.addSubview(_view)
        view.bringSubviewToFront(btnContainer)
    }
}
