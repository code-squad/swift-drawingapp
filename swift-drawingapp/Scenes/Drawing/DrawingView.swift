//
//  DrawingView.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import UIKit
import Combine

class DrawingView: UIView {
    private let info: any Drawable

    private let path: UIBezierPath = .init()
    private var canDrawing: Bool = true
    private var points: [CGPoint] = []

    private var cancellables: Set<AnyCancellable> = []

    init(info: any Drawable) {
        self.info = info
        super.init(frame: CGRect.frame(info.area))
        isMultipleTouchEnabled = false
        backgroundColor = .clear
        path.lineWidth = info.lineWidth

        info.areaPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: setFrame)
            .store(in: &cancellables)

        info.pointsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: drawPoints)
            .store(in: &cancellables)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canDrawing else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        points.append(location)
        path.move(to: location)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canDrawing else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        points.append(location)
        path.addLine(to: location)
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canDrawing else { return }
        defer { points.removeAll() }
        canDrawing = false
        info.resizeToDrawnArea(with: points.map { Point(x: $0.x, y: $0.y) })
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }

    override func draw(_ rect: CGRect) {
        UIColor.system(info.color).setStroke()
        path.stroke()
    }

    private func setFrame(area: Area) {
        frame = CGRect.frame(area)
    }

    private func drawPoints(_ points: [Point]) {
        path.removeAllPoints()
        var isFirstPoint: Bool = true
        points.forEach {
            let point = CGPoint(x: $0.x, y: $0.y)
            if isFirstPoint {
                path.move(to: point)
                isFirstPoint = false
            }
            path.addLine(to: point)
        }
        setNeedsDisplay()
    }
}
