//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

protocol CanvasViewDelegate: AnyObject {
    
    func canvasView(_ canvasView: CanvasView, didTapEndedAt: CGPoint)
    
    func canvasView(_ canvasView: CanvasView, didDragBeganAt: CGPoint)
    
    func canvasView(_ canvasView: CanvasView, didDragValueChangedAt: CGPoint)
    
    func canvasView(_ canvasView: CanvasView, didDragEndedAt: CGPoint)
}

final class CanvasView: UIView {
    
    weak var delegate: CanvasViewDelegate?
    
    private var strokes: [Stroke] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(sender:)))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        for stroke in strokes {
            let bezierPath = UIBezierPath()
            guard !stroke.points.isEmpty, let firstPoint = stroke.points.first?.toCGPoint else { continue }
            bezierPath.move(to: firstPoint)
            for point in stroke.points {
                bezierPath.addLine(to: point.toCGPoint)
            }
            bezierPath.lineWidth = stroke.ink.lineWidth
            bezierPath.lineCapStyle = .round
            bezierPath.lineJoinStyle = .round
            stroke.ink.lineColor.toSystemColor.set()
            bezierPath.stroke()
        }
    }
    
    func update(drawing: Drawing) {
        reset()
        
        strokes = drawing.items.values
            .compactMap { $0 as? Stroke }
        
        drawing.items.values
            .compactMap { $0 as? Rectangle }
            .forEach {
                
                let view = RectangleView(
                    uuidString: $0.id,
                    frame: CGRect(origin: .zero, size: ($0.layoutInfo?.size?.toCGSize ?? .zero))
                )
                
                if drawing.selectedItems[$0.id] != nil {
                    view.layer.borderColor = UIColor.systemRed.cgColor
                    view.layer.borderWidth = 3
                } else {
                    view.layer.borderColor = $0.uiInfo?.borderColor?.toSystemColor.cgColor
                    view.layer.borderWidth = $0.uiInfo?.borderWidth ?? 3.0
                }

                view.backgroundColor = $0.uiInfo?.backgroundColor?.toSystemColor.withAlphaComponent(0.8)
                view.center = ($0.layoutInfo?.center?.toCGPoint ?? .zero)
                
                addSubview(view)
            }
        
        layoutIfNeeded()
        setNeedsLayout()
    }
    
    func update(selectedItems: Drawing.DataType) {
        
        subviews.forEach {
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.layer.borderWidth = 3
        }
        
        subviews
            .compactMap { $0 as? RectangleView }
            .forEach {
                if selectedItems[$0.uuidString] != nil {
                    $0.layer.borderColor = UIColor.systemRed.cgColor
                    $0.layer.borderWidth = 3
                }
            }
    }
    
    func reset() {
        strokes.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
    }
}

private extension CanvasView {
    
    func setup() {
        addGestureRecognizer(tapGestureRecognizer)
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        switch sender.state {
        case .ended:
            delegate?.canvasView(self, didTapEndedAt: point)

        default:
            break
        }
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            delegate?.canvasView(self, didDragBeganAt: sender.location(in: self))
                
        case .changed:
            delegate?.canvasView(self, didDragValueChangedAt: sender.location(in: self))
                
        case .ended:
            delegate?.canvasView(self, didDragEndedAt: sender.location(in: self))
            
        default:
            break
        }
    }
}

extension CanvasView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == tapGestureRecognizer && otherGestureRecognizer == panGestureRecognizer {
            return true
        }
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
