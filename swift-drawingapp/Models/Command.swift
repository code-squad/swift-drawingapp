//
//  Command.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/26.
//

import Foundation

struct Command: Encodable {
    let header: String
    let id: String
    let length: Int?
    let data: Data?
}
