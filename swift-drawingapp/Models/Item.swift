//
//  Item.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

class Item: Codable {
    
    var id: String

    var layoutInfo: LayoutInfo? = nil
    
    var uiInfo: UIInfo? = nil
    
    var toJSON: String { "" }
    
    init(id: String, layoutInfo: LayoutInfo? = nil, uiInfo: UIInfo? = nil) {
        self.id = id
        self.layoutInfo = layoutInfo
        self.uiInfo = uiInfo
    }
}

extension Item {
    
    var frame: CGRect {
        guard let centerX = layoutInfo?.center?.x, let centerY = layoutInfo?.center?.y,
              let width = layoutInfo?.size?.width, let height = layoutInfo?.size?.height else { return .zero }
        return CGRect(x: centerX - (width / 2), y: centerY - (height / 2), width: width, height: height)
    }
}
