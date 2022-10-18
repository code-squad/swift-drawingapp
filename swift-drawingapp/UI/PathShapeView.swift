//
//  PathShapeView.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import UIKit
import Combine

final class PathShapeView: UIView {

    var tapPublisher = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    private(set) var isSelected: Bool = false
    private var pathShape: PathShape?

    convenience init(_ pathShape: PathShape) {
        self.init(frame: CGRect(origin: pathShape.origin, size: pathShape.size))
        layer.borderWidth = pathShape.isSelected ? 3 : 0
        isSelected = pathShape.isSelected
        layer.borderColor = UIColor.systemRed.cgColor
        self.pathShape = pathShape
        configure()
        guard var startPoint = pathShape.paths.first else { return }
        var newPaths = pathShape.paths
        newPaths.removeFirst()
        newPaths.forEach { point in
            drawLineFromPoint(start: startPoint, toPoint: point, ofColor: pathShape.color, inView: self)
            startPoint = point
        }
        clipsToBounds = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure() {
        let gestureForRect = UITapGestureRecognizer()
        gestureForRect.addTarget(self, action: #selector(didTap(_:)))
        self.addGestureRecognizer(gestureForRect)
        backgroundColor = .clear
    }

    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.addLine(to: end)

        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 3.0

        view.layer.addSublayer(shapeLayer)
    }

    @objc func didTap(_ sender: UITapGestureRecognizer) {
        tapPublisher.send(())
    }

}
