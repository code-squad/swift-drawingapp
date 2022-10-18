//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

protocol CanvasViewDelegate: AnyObject {
    
    func canvasView(_ canvasView: CanvasView, selectedItem: Item)
    
    func canvasView(_ canvasView: CanvasView, didTapEndedAt: CGPoint)
    
    func canvasView(_ canvasView: CanvasView, didDragBeganAt: CGPoint)
    
    func canvasView(_ canvasView: CanvasView, didDragValueChangedAt: CGPoint)
    
    func canvasView(_ canvasView: CanvasView, didDragEndedAt: CGPoint)
}

final class CanvasView: UIView {
    
    weak var delegate: CanvasViewDelegate?
    
    private var items: [Item] {
        subviews.compactMap { $0 as? Item } + strokes.map { $0 as Item }
    }
    
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
        
        strokes = drawing.items
            .filter { $0 is Stroke }
            .compactMap { $0 as? Stroke }
        
        drawing.items
            .filter { $0 is RectangleView }
            .compactMap { $0 as? RectangleView }
            .forEach {
                $0.frame = CGRect(origin: .zero, size: ($0.layoutInfo.size ?? .zero).toCGSize)
                $0.backgroundColor = $0.uiInfo.backgroundColor?.toSystemColor.withAlphaComponent(0.8)
                $0.center = ($0.layoutInfo.center ?? .zero).toCGPoint
                addSubview($0)
            }
        
        layoutIfNeeded()
        setNeedsLayout()
    }
    
    func update(selectedItems: [Item]) {
        items.compactMap { $0 as? UIView }
            .forEach {
                $0.layer.borderColor = UIColor.clear.cgColor
                $0.layer.borderWidth = 3
            }
        
        selectedItems.compactMap { $0 as? UIView }
            .forEach {
                $0.layer.borderColor = UIColor.systemRed.cgColor
                $0.layer.borderWidth = 3
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
    
    func findSelectedItem(point: CGPoint) -> Item? {
        return subviews.reversed().first { $0.frame.contains(point) } as? Item
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        switch sender.state {
        case .ended:
            if let selectedItem = findSelectedItem(point: point) {
                delegate?.canvasView(self, selectedItem: selectedItem)
            } else {
                delegate?.canvasView(self, didTapEndedAt: point)
            }
            
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
