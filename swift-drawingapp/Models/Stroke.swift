//
//  Stroke.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import Foundation

class Stroke: Item, Identifiable {
    
    var id: UUID
    
    var points: [Point]
    
    var ink: Ink
    
    init(id: UUID = UUID(), positions: [Point] = [], ink: Ink) {
        self.id = id
        self.points = positions
        self.ink = ink
    }
}
