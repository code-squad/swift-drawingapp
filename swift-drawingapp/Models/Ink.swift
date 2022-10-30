//
//  Ink.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/18.
//

import Foundation

struct Ink: Codable {
    
    var lineWidth: Double
    
    var lineColor: String
    
    static let `default` = Ink(lineWidth: 3, lineColor: "systemBlue")
}
