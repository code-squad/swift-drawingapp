//
//  ItemSelectionUseCaseImpl.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import Foundation

class ItemSelectionUseCaseImpl: ItemSelectionUseCase {
    
    func select(_ drawing: Drawing, item: Item) -> Drawing.DataType {
        if let item = drawing.selectedItems[item.id] {
            drawing.selectedItems[item.id] = nil
        } else {
            drawing.selectedItems[item.id] = item
        }
        return drawing.selectedItems
    }
    
    func find(items: [Item], point: Point) -> Item? {
        guard let item = items.first(where: { $0.frame.contains(point.toCGPoint) }) else { return nil }
        return item
    }
}
