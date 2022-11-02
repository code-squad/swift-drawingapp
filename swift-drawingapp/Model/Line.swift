//
//  Line.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/22.
//

import Foundation
import CoreGraphics

class Line: Shape, Identifiable, Codable {
    let uuid: UUID
    private(set) var points: [CGPoint]
    
    init(points: [CGPoint]) {
        self.uuid = UUID()
        self.points = points
    }
    
    func append(point: CGPoint) {
        self.points.append(point)
    }
    
    func toJsonData() -> Data? {
        if let jsonData = try? JSONEncoder().encode(self) {
            return jsonData
        }
        return nil
    }
}

