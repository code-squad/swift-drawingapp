//
//  ShapeProtocol.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

protocol ShapeProtocol: Identifiable where ID == UUID {
    
    var points: [Point] { get }
}

extension ShapeProtocol {
    func canAdd(to sizeOfCanvas: Size) -> Bool {
        for point in points {
            guard sizeOfCanvas.contains(point) else { return false }
        }
        return true
    }
}
