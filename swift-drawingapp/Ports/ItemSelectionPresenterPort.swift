//
//  ItemSelectionPresenterPort.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/30.
//

import Foundation

protocol ItemSelectionPresenterPort: AnyObject {
    
    func update(selectedItems: Drawing.DataType)
}
