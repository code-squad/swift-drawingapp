//
//  InkDrawingUseCase.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import Foundation

protocol InkDrawingUseCase {
    
    var drawing: Drawing { get }
    
    var selectedTool: Tool { get }
    
    var currentDrawingStroke: Stroke? { get }
    
    @discardableResult
    func draw(tool: Tool, beganAt: Point) -> Drawing
    
    @discardableResult
    func draw(tool: Tool, valueChangedAt: Point) -> Drawing
    
    @discardableResult
    func draw(tool: Tool, endedAt: Point) -> Drawing
    
    func create(positions: [Point], ink: Ink) -> Stroke
    
    func update(_ drawing: Drawing, stroke: Stroke)
    
    func update(_ drawing: Drawing, stroke: Stroke, points: [Point])
    
    func reset()
    
    func setPresenter(with port: InkDrawingPresenterPort)
}
