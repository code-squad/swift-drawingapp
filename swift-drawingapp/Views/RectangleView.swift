//
//  RectangleView.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

class RectangleView: UIView, Item, Identifiable {
    
    var id: UUID
    
    var layoutInfo: LayoutInfo
    
    var uiInfo: UIInfo
    
    init(id: UUID = UUID(), layoutInfo: LayoutInfo = .init(), uiInfo: UIInfo = .init()) {
        self.id = id
        self.layoutInfo = layoutInfo
        self.uiInfo = uiInfo
        super.init(frame: CGRect(origin: .zero, size: (layoutInfo.size ?? .zero).toCGSize))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
