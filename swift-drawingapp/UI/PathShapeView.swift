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
    private(set) var shapeLayer = CAShapeLayer()
    private var pathShape: PathShape?

    convenience init(_ pathShape: PathShape) {
        self.init(frame: CGRect(origin: pathShape.origin, size: pathShape.size))
        layer.borderWidth = pathShape.isSelected ? 3 : 0
        isSelected = pathShape.isSelected
        layer.borderColor = UIColor.systemRed.cgColor
        self.pathShape = pathShape
        configure(pathShape: pathShape)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(pathShape: PathShape) {
        let gestureForRect = UITapGestureRecognizer()
        gestureForRect.addTarget(self, action: #selector(didTap(_:)))
        self.addGestureRecognizer(gestureForRect)
        backgroundColor = .clear

        guard let startPoint = pathShape.paths.first else { return }

        let path = UIBezierPath()
        path.move(to: startPoint)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round

        var newPaths = pathShape.paths
        newPaths.removeFirst()
        newPaths.forEach { point in
            path.addLine(to: point)
        }

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = pathShape.color.cgColor
        shapeLayer.fillColor = .none
        shapeLayer.lineWidth = 3.0

        layer.addSublayer(shapeLayer)
        clipsToBounds = false
    }

    @objc func didTap(_ sender: UITapGestureRecognizer) {
        tapPublisher.send(())
    }

}
