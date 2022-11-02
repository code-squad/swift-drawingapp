//
//  RectangleView.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import UIKit
import Combine

final class RectangleView: UIView, PictureView {
    private let lineWidth: CGFloat
    private weak var port: DrawUIInPort?

    private var isSelected: Bool = false

    init(frame: CGRect, color: UIColor, lineWidth: CGFloat, port: DrawUIInPort) {
        self.lineWidth = lineWidth
        self.port = port
        super.init(frame: frame)
        isMultipleTouchEnabled = false
        backgroundColor = color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        port?.touch(on: self, at: nil)
    }

    func selected(at point: Point?) {
        isSelected.toggle()
        layer.borderColor = isSelected ? UIColor.systemRed.cgColor : UIColor.clear.cgColor
        layer.borderWidth = isSelected ? lineWidth : 0
    }
}


