//
//  Line.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/22.
//

import Foundation
import CoreGraphics

class Line: Shape, Identifiable, Codable {
    var uuid: UUID
    var points: [CGPoint]
    
    init(points: [CGPoint]) {
        self.uuid = UUID()
        self.points = points
    }
    
    func toJsonData() -> Data? {
        if let jsonData = try? JSONEncoder().encode(self) {
            return jsonData
        }
        return nil
    }
}

