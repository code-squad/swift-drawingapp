//
//  RectangleView.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import UIKit
import Combine

class RectangleView: UIView {
    private let info: any RectangleInPort
    private var isSelected: Bool = false

    init(info: any RectangleInPort) {
        self.info = info
        super.init(frame: CGRect.frame(info.area))
        isMultipleTouchEnabled = false
        backgroundColor = UIColor.system(info.color)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isSelected ? info.deactivate() : info.activate()
    }

    func drawBorder(_ isActive: Bool) {
        isSelected = isActive
        layer.borderColor = isSelected ? UIColor.systemRed.cgColor : UIColor.clear.cgColor
        layer.borderWidth = isSelected ? info.lineWidth : 0
    }
}
