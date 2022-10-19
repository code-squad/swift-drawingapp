//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by USER on 2022/10/20.
//

import UIKit

final class DrawView: ShapeView {
    private let drawingGesture = UIPanGestureRecognizer()
    private var path: UIBezierPath = UIBezierPath()
    private var pathX: CGFloat = .infinity
    private var pathY: CGFloat = .infinity
    var lineColor: UIColor = .black
    
    public override init() {
        super.init()
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        
        path.lineWidth = 2
        path.lineCapStyle = .round
        self.lineColor.setStroke()
        path.stroke()
    }
    
    private func addGesture() {
        drawingGesture.cancelsTouchesInView = false
        drawingGesture.isEnabled = true
        drawingGesture.minimumNumberOfTouches = 1
        drawingGesture.maximumNumberOfTouches = 1
        drawingGesture.addTarget(self, action: #selector(panGestureHandler(_:)))
        addGestureRecognizer(drawingGesture)
    }
    
    @objc
    private func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self)

        switch sender.state {
        case .began:
            drawLine(to: point,from: point)
        case .changed:
            drawLine(from: point)
        case .ended:
            drawLine(from: point)
            endedDraw()
        default:
          return
        }
    }
    
    private func drawLine(to: CGPoint? = nil, from: CGPoint) {
        if let to = to {
            path.move(to: to)
            savePathOrigin(to)
        }
        path.addLine(to: from)
        savePathOrigin(from)
        setNeedsDisplay()
    }
    
    private func savePathOrigin(_ point: CGPoint) {
        pathX = min(pathX, point.x)
        pathY = min(pathY, point.y)
    }
    
    private func endedDraw() {
        // MARK: view resizing
        let origin = CGPoint(x: pathX, y: pathY)
        self.frame = CGRect(origin: origin,
                            size: path.bounds.size)
        path.apply(CGAffineTransform(translationX: -origin.x, y: -origin.y))
        setNeedsDisplay()
        
        // MARK: remove gesture
        self.removeGestureRecognizer(drawingGesture)
    }
}

