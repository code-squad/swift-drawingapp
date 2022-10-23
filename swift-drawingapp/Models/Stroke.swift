//
//  Stroke.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import Foundation

struct Stroke: Item {
    
    var id: String
    
    var points: [Point]
    
    var ink: Ink
    
    init(id: String = UUID().uuidString, positions: [Point] = [], ink: Ink) {
        self.id = id
        self.points = positions
        self.ink = ink
    }
}
