//
//  Command.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/03.
//

import Foundation

struct Command : Codable {
    let header : String
    let id : String
    let length : Int?
    let data : Data?
}
