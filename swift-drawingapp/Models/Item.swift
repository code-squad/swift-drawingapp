//
//  Item.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

protocol Item {
    
    var id: String { get }

    var layoutInfo: LayoutInfo? { get set }
    
    var uiInfo: UIInfo? { get set }
    
    var frame: CGRect { get }
}

extension Item {
     
    var layoutInfo: LayoutInfo? {
        get { return nil }
        set {}
    }
    
    var uiInfo: UIInfo? {
        get { return nil }
        set {}
    }
    
    var frame: CGRect {
        guard let centerX = layoutInfo?.center?.x, let centerY = layoutInfo?.center?.y,
              let width = layoutInfo?.size?.width, let height = layoutInfo?.size?.height else { return .zero }
        return CGRect(x: centerX - (width / 2), y: centerY - (height / 2), width: width, height: height)
    }
}
