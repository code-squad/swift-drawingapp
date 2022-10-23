//
//  ToolSelectionUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import Foundation

protocol ToolSelectionUseCase {
    
    func create(toolInfo: ToolInfo) -> Tool
}
