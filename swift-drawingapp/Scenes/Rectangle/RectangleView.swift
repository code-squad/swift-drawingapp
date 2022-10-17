//
//  RectangleView.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import UIKit
import Combine

class RectangleView: UIView {
    private let info: any Paintable & Selectable
    private var cancellables: Set<AnyCancellable> = []

    init(info: any Paintable & Selectable) {
        self.info = info
        super.init(frame: CGRect.frame(info.area))
        isMultipleTouchEnabled = false
        backgroundColor = UIColor.system(info.color)
        info.isSelectedPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: drawBorder)
            .store(in: &cancellables)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        info.select()
    }

    private func drawBorder(_ isSelected: Bool) {
        layer.borderColor = isSelected ? UIColor.systemRed.cgColor : UIColor.clear.cgColor
        layer.borderWidth = isSelected ? 4 : 0
    }
}
