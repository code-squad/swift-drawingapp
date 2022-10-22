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
}
