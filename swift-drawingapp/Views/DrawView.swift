//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by USER on 2022/10/20.
//

import UIKit

final class DrawView: ShapeView {
    private let drawingGesture = UIPanGestureRecognizer()
    private var pathX: CGFloat = .infinity
    private var pathY: CGFloat = .infinity
    
    private lazy var path: UIBezierPath = {
        let path = UIBezierPath()
        path.lineWidth = 2
        path.lineCapStyle = .round
        return path
    }()
    
    var lineColor: UIColor = .black
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        lineColor.setStroke()
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
        defer {
            setNeedsDisplay()
        }
        
        let point = sender.location(in: self)
        switch sender.state {
        case .began:
            path.move(to: point)
            savePathOrigin(point)
            
        case .changed, .ended:
            path.addLine(to: point)
            savePathOrigin(point)
            
            if sender.state == .ended { endedGesture() }
        default:
            return
        }
    }
    
    private func savePathOrigin(_ point: CGPoint) {
        pathX = min(pathX, point.x)
        pathY = min(pathY, point.y)
    }
    
    private func endedGesture() {
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

