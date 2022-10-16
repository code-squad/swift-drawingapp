//
//  DrawingStore.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/14.
//

import Foundation
import QuartzCore

struct DrawingModel: Identifiable {
    let id = UUID()
    let type: DrawingType
    let layer: CAShapeLayer
}

class DrawingStore {
    
    var drawingList = [DrawingModel]()
    
    init() { }
    
    func appendData(data: DrawingModel) {
        drawingList.append(data)
    }
}
