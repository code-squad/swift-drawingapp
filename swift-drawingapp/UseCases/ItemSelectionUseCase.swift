//
//  ItemSelectionUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import Foundation

protocol ItemSelectionUseCase {
    
    func select(_ drawing: Drawing, item: Item) -> Drawing.DataType
    
    func find(items: [Item], point: Point) -> Item?
}
