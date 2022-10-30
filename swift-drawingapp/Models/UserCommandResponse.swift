//
//  UserCommandResponse.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/31.
//

import Foundation

struct UserCommandResponse: Decodable {
    let header : String
    let id : String
    let drawing: [Drawing.DataType]?
}
