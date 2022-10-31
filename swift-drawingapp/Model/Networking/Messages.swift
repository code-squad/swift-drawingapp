//
//  Messages.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/23.
//

import Foundation

struct Command : Codable {
    var header : Header
    var id : String
    var length : Int?
    var data : Data?
    
    enum Header: String, Codable {
        case login = "0x10"
        case chat = "0x20"
    }
}

struct CommandResponse : Decodable {
    let header : String
    let id : String
}
