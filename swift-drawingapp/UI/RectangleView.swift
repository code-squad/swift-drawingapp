//
//  RectangleView.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import UIKit
import Combine

final class RectangleView: UIView {

    var tapPublisher = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()
    private(set) var isSelected: Bool = false

    convenience init(_ rectangle: Rectangle) {
        self.init(frame: CGRect(origin: rectangle.origin, size: rectangle.size))
        backgroundColor = rectangle.color
        layer.borderWidth = rectangle.isSelected ? 3 : 0
        isSelected = rectangle.isSelected
        layer.borderColor = UIColor.systemRed.cgColor
        configure()
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
        addGestureRecognizer(gestureForRect)
    }

    @objc func didTap(_ sender: UITapGestureRecognizer) {
        tapPublisher.send(())
    }
}
