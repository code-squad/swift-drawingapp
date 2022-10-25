//
//  DrawingStore.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/14.
//

import Foundation
import CoreGraphics

protocol DrawingStoreProtocol {
    func appendData(data: Shape)
    func getData() -> [Shape]
    func findSquare(point: CGPoint) -> Square?
}

class DrawingStore: DrawingStoreProtocol {
    
    private var drawingList = [Shape]()
    
    init() { }
    
    func appendData(data: Shape) {
        drawingList.append(data)
    }
    
    func getData() -> [Shape] {
        return drawingList
    }
    
    func findSquare(point: CGPoint) -> Square? {
        let drawing = drawingList
            .compactMap { $0 as? Square }
            .first { $0.isContain(point: point) }
        
        return drawing
    }
}
