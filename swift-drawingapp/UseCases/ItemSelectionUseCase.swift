//
//  ItemSelectionUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import Foundation

protocol ItemSelectionUseCase {
    
    var drawing: Drawing { get }
    
    @discardableResult
    func select(_ drawing: Drawing, item: Item) -> Drawing.DataType
    
    func find(items: [Item], point: Point) -> Item?
    
    func setPresenter(with port: ItemSelectionPresenterPort)
}
