//
//  RectangleInfo.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/18.
//

import Foundation
import Combine

protocol Selectable {
    var isSelectedPublisher: Published<Bool>.Publisher { get }
    func select()
}

final class RectangleInfo: Paintable, Selectable {
    let color: Color
    let area: Area

    var isSelectedPublisher: Published<Bool>.Publisher { $isSelected }
    @Published private var isSelected: Bool = false

    init(color: Color, area: Area) {
        self.color = color
        self.area = area
    }

    func select() {
        isSelected.toggle()
    }
}
