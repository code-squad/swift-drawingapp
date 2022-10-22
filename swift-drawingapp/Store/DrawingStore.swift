//
//  DrawingStore.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/14.
//

import Foundation
import CoreGraphics

class DrawingStore {
    
    var drawingList = [Shape]()
    
    init() { }
    
    func appendData(data: Shape) {
        drawingList.append(data)
    }
    
    func updateData(data: [Shape]) {
        drawingList = data
    }
}
