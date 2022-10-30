//
//  ToolSelectionUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import Foundation

protocol ToolSelectionUseCase {
    
    var selectedTool: Tool { get }
    
    @discardableResult
    func select(toolInfo: ToolInfo) -> Tool
    
    func setPresenter(with port: ToolSelectionPresenterPort)
}
