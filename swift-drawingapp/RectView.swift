//
//  RectView.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import UIKit

final class RectView: UIButton {
    let id: UUID
    override var isSelected: Bool {
        didSet {
            isSelected ? select() : deselect()
        }
    }

    init(id: UUID) {
        self.id = id
        super.init(frame: .zero)

        layer.borderColor = UIColor.systemRed.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func select() {
        layer.borderWidth = 4
    }

    private func deselect() {
        layer.borderWidth = 0
    }
}
