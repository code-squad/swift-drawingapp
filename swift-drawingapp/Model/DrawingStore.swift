//
//  DrawingStore.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/14.
//

import Foundation
import CoreGraphics

struct DrawingModel: Identifiable {
    let id = UUID()
    let type: DrawingType
    let points: [CGPoint]
}

class DrawingStore {
    
    var drawingList = [DrawingModel]()
    
    init() { }
    
    func appendData(data: DrawingModel) {
        drawingList.append(data)
    }
}
