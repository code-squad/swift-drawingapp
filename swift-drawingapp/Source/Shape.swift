//
//  Shape.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class Shape {
    
    var points: [Point] = []
    
    private(set) var canvas: Canvas?
    
    func setCanvas(_ canvas: Canvas) {
        self.canvas = canvas
    }
}
