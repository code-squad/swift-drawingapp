//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import Foundation

struct Rectangle: Item {
    
    let id: String
    
    var layoutInfo: LayoutInfo?
    
    var uiInfo: UIInfo?

    init(id: String = UUID().uuidString, layoutInfo: LayoutInfo = .init(), uiInfo: UIInfo = .init()) {
        self.id = id
        self.layoutInfo = layoutInfo
        self.uiInfo = uiInfo
    }
}
