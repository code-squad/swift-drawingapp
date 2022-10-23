//
//  ToolSelectionUserCaseImpl.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import Foundation

struct ToolSelectionUseCaseImpl: ToolSelectionUseCase {
    
    func create(toolInfo: ToolInfo) -> Tool {
        switch toolInfo.type {
        case "polygon":
            return PolygonTool()
            
        case "ink":
            if let lineWidth = toolInfo.options?["width"] as? Double,
               let lineColor = toolInfo.options?["color"] as? String {
                return InkTool(ink: Ink(lineWidth: lineWidth, lineColor: lineColor))
            }
            return InkTool(ink: Ink(lineWidth: 3, lineColor: "systemBlue"))
            
        default:
            return PolygonTool()
        }
    }
}
