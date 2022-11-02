//
//  DrawingView.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import UIKit

final class DrawingView: UIView, PictureView {
    private let color: UIColor
    private let path: UIBezierPath = .init()
    private var lastPoint: CGPoint? = nil

    private weak var port: DrawUIInPort?

    init(frame: CGRect, color: UIColor, lineWidth: CGFloat, port: DrawUIInPort) {
        self.color = color
        self.port = port
        super.init(frame: frame)
        isMultipleTouchEnabled = false
        isUserInteractionEnabled = true
        backgroundColor = .clear
        path.lineWidth = lineWidth
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        port?.touch(on: self, at: touch.location(in: self))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        port?.touch(on: self, at: touch.location(in: self))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        port?.touch(on: self, at: nil)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }

    override func draw(_ rect: CGRect) {
        color.setStroke()
        path.stroke()
    }

    func selected(at point: Point?) {
        if point == nil, lastPoint == nil {
            path.removeAllPoints()
        } else if let point, lastPoint == nil {
            path.move(to: CGPoint(x: point.x, y: point.y))
            lastPoint = CGPoint(x: point.x, y: point.y)
        } else if let point, lastPoint != nil {
            path.addLine(to: CGPoint(x: point.x, y: point.y))
            setNeedsDisplay()
            lastPoint = CGPoint(x: point.x, y: point.y)
        } else {
            isUserInteractionEnabled = false
            lastPoint = nil
        }
    }
}
