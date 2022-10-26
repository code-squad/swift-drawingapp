//
//  DrawingCanvasView.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import UIKit

protocol DrawingCanvasViewDelegate {
    func drawingCanvasView(didDrawTo path: CGPoint)
}

final class DrawingCanvasView: UIView {
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let tempImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(mainImageView)
        addSubview(tempImageView)

        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tempImageView.topAnchor.constraint(equalTo: topAnchor),
            tempImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tempImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tempImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
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

        mergeImage()
        isDrawing = false
    }

    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: bounds)

        context.move(to: fromPoint)
        context.addLine(to: toPoint)

        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(8)
        context.setStrokeColor(drawingColor.cgColor)

        context.strokePath()

        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
    }

    private func mergeImage() {
        UIGraphicsBeginImageContext(frame.size)
        mainImageView.image?.draw(in: bounds, blendMode: .normal, alpha: 1.0)
        tempImageView.image?.draw(in: bounds, blendMode: .normal, alpha: 1.0)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        tempImageView.image = nil
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
