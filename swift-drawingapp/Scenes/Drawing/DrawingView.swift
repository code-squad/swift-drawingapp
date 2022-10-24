//
//  DrawingView.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import UIKit
import Combine

class DrawingView: UIView {
    private let info: any DrawingInPort

    private let path: UIBezierPath = .init()
    private var lastPoint: CGPoint? = nil

    private var cancellables: Set<AnyCancellable> = []

    init(info: any DrawingInPort) {
        self.info = info
        super.init(frame: CGRect.frame(info.area))
        isMultipleTouchEnabled = false
        backgroundColor = .clear
        path.lineWidth = info.lineWidth
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        info.activate()
        let location = touch.location(in: self)
        info.touch(location: location.convertToPoint())
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        info.touch(location: location.convertToPoint())
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        info.touch(location: location.convertToPoint())
        info.deactivate()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }

    override func draw(_ rect: CGRect) {
        UIColor.system(info.color).setStroke()
        path.stroke()
    }

    func setFrame(area: Area) {
        frame = CGRect.frame(area)
    }

    func draw(_ point: Point?) {
        guard let point else {
            lastPoint = nil
            path.removeAllPoints()
            return
        }
        if lastPoint == nil {
            path.move(to: CGPoint(x: CGFloat(point.x), y: CGFloat(point.y)))
        } else {
            path.addLine(to: CGPoint(x: CGFloat(point.x), y: CGFloat(point.y)))
            setNeedsDisplay()
        }
        lastPoint = CGPoint(x: point.x, y: point.y)
    }

    func activeControl(_ isActive: Bool) {
        if isActive {
            lastPoint = nil
        }
        isUserInteractionEnabled = isActive
    }
}
