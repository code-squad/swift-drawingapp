//
//  DrawingCanvasView.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import UIKit

protocol DrawingCanvasViewDelegate {
    func drawingCanvasView(didDrawTo path: CGPoint)
    func endDrawing()
}

final class DrawingCanvasView: UIView {
    private let tempDrawingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var lastPoint: CGPoint = .zero
    var drawingColor: UIColor = .white
    private var isDrawing: Bool = false {
        didSet {
            isDrawing ? showIsDrawing() : hideIsDrawing()
        }
    }
    var delegate: DrawingCanvasViewDelegate?

    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        addSubview(tempDrawingView)

        NSLayoutConstraint.activate([
            tempDrawingView.topAnchor.constraint(equalTo: topAnchor),
            tempDrawingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tempDrawingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tempDrawingView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, isDrawing else {
            super.touchesBegan(touches, with: event)
            return
        }

        lastPoint = touch.location(in: self)
        delegate?.drawingCanvasView(didDrawTo: lastPoint)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, isDrawing else {
            super.touchesMoved(touches, with: event)
            return
        }

        let currentPoint = touch.location(in: self)
        drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
        delegate?.drawingCanvasView(didDrawTo: lastPoint)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {
            super.touchesEnded(touches, with: event)
            return
        }

        delegate?.endDrawing()

        clearTemps()
        isDrawing = false
    }

    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        let path = UIBezierPath()
        path.move(to: fromPoint)
        path.addLine(to: toPoint)

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 8
        shape.fillColor = nil
        shape.strokeColor = drawingColor.cgColor
        tempDrawingView.layer.addSublayer(shape)
    }

    func clearTemps() {
        tempDrawingView.layer.sublayers = nil
    }

    func addDrawing(_ drawing: Drawing) {
        let path = UIBezierPath()
        drawing.paths
            .enumerated()
            .forEach {
                if $0.offset == 0 {
                    path.move(to: .init(x: $0.element.x, y: $0.element.y))
                } else {
                    path.addLine(to: .init(x: $0.element.x, y: $0.element.y))
                }
            }

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 8
        shape.strokeColor = drawingColor.cgColor
        shape.fillColor = nil
        layer.addSublayer(shape)
    }

    func enableDrawing() {
        isDrawing = true
    }

    private func showIsDrawing() {
        layer.borderColor = UIColor.systemRed.cgColor
        layer.borderWidth = 1
    }

    private func hideIsDrawing() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0
    }
}
